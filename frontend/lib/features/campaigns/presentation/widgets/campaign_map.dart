import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:frontend/core/styles/map_style.dart';
import 'package:frontend/core/theme/app_theme.dart';

class CampaignMap extends StatefulWidget {
  const CampaignMap({super.key});

  @override
  State<CampaignMap> createState() => _CampaignMapState();
}

class _CampaignMapState extends State<CampaignMap> {
  final Completer<GoogleMapController> _mapController = Completer<GoogleMapController>();
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
    return Stack(
      children: [
        SizedBox.expand(
          child: GoogleMap(
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
        ),
        if (!_mapInitialized)
          const Center(
            child: CircularProgressIndicator(),
          ),
      ],
    );
  }
} 