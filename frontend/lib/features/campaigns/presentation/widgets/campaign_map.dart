import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/campaign_provider.dart';
import 'package:geolocator/geolocator.dart';

class CampaignMap extends ConsumerStatefulWidget {
  @override
  ConsumerState<CampaignMap> createState() => _CampaignMapState();
}

class _CampaignMapState extends ConsumerState<CampaignMap> {
  LatLng? _currentPosition;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    
    try {
      // Check services
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return;
      }

      // Check permission
      LocationPermission permission = await Geolocator.checkPermission();
      
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return;
        }
      }

      // Get location
      Position position = await Geolocator.getCurrentPosition();
      
      setState(() {
        _currentPosition = LatLng(position.latitude, position.longitude);
      });
    } catch (e) {

    }
  }

  @override
  Widget build(BuildContext context) {
    final campaignsAsync = ref.watch(campaignNotifierProvider);

    return campaignsAsync.when(
      data: (campaigns) {
        
        return GoogleMap(
          initialCameraPosition: CameraPosition(
            target: _currentPosition ?? LatLng(40.7128, -74.0060),
            zoom: 10,
          ),
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          onMapCreated: (controller) {
          },
          markers: campaigns.map((campaign) {
            return Marker(
              markerId: MarkerId(campaign.id),
              position: LatLng(campaign.locationLat, campaign.locationLng),
              infoWindow: InfoWindow(
                title: campaign.title,
                snippet: '\$${campaign.targetAmount}',
              ),
            );
          }).toSet(),
        );
      },
      loading: () {
        return const Center(child: CircularProgressIndicator());
      },
      error: (error, stack) {
        return Center(child: Text('Error: $error'));
      },
    );
  }
}
