import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:frontend/core/styles/map_style.dart';
import 'package:frontend/core/themes/app_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/campaign_provider.dart';

class CampaignMap extends ConsumerStatefulWidget {
  const CampaignMap({super.key});

  @override
  ConsumerState<CampaignMap> createState() => _CampaignMapState();
}

class _CampaignMapState extends ConsumerState<CampaignMap> {
  final Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();
  bool _mapInitialized = false;
  final Set<Marker> _markers = <Marker>{};

  void _onMapCreated(GoogleMapController controller) {
    if (!mounted) return;
    _mapController.complete(controller);
    setState(() {
      _mapInitialized = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final campaignsAsync = ref.watch(campaignNotifierProvider);

    return campaignsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
      data: (campaigns) {
        // Update markers based on campaigns
        _markers.clear();
        for (var campaign in campaigns) {
          _markers.add(
            Marker(
              markerId: MarkerId(campaign.id),
              position: LatLng(campaign.locationLat, campaign.locationLng),
              infoWindow: InfoWindow(
                title: campaign.title,
                snippet: campaign.description,
              ),
            ),
          );
        }

        return Stack(
          children: [
            GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: const CameraPosition(
                target: LatLng(40.7128, -74.0060),
                zoom: 12.0,
              ),
              markers: _markers,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              mapType: MapType.normal,
              zoomControlsEnabled: true,
              zoomGesturesEnabled: true,
              style: MapStyle.darkStyle(AppTheme.buttonRed),
            ),
            if (!_mapInitialized)
              const Center(child: CircularProgressIndicator()),
          ],
        );
      },
    );
  }
}
