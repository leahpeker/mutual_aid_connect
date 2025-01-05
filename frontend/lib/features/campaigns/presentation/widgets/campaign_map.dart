import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/campaign_provider.dart';
import 'package:geolocator/geolocator.dart';
import '../../domain/models/campaign.dart';

class CampaignMap extends ConsumerStatefulWidget {
  @override
  ConsumerState<CampaignMap> createState() => _CampaignMapState();
}

class _CampaignMapState extends ConsumerState<CampaignMap> {
  LatLng? _currentPosition;
  GoogleMapController? _mapController;

  @override
  void initState() {
    super.initState();
    print('CampaignMap: initState called');
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
    } catch (e) {}
  }

  void _showCampaignDetails(BuildContext context, Campaign campaign) {
    print('CampaignMap: showing details for campaign ${campaign.id}');
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              campaign.title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(campaign.description),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '\$${campaign.currentAmount.toStringAsFixed(2)} raised',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Text(
                  'of \$${campaign.targetAmount.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: campaign.currentAmount / campaign.targetAmount,
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // TODO: Implement support action
                  print('Support button pressed for campaign: ${campaign.id}');
                },
                child: const Text('Support This Campaign'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    print('CampaignMap: dispose called');
    _mapController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('CampaignMap: build called');
    final campaignsAsync = ref.watch(campaignNotifierProvider);
    print('CampaignMap: campaign state: $campaignsAsync');

    return SafeArea(
      child: campaignsAsync.when(
        data: (campaigns) {
          print('CampaignMap: rendering map with ${campaigns.length} campaigns');
          return GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _currentPosition ?? LatLng(40.7128, -74.0060),
              zoom: 10,
            ),
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            onMapCreated: (GoogleMapController controller) {
              print('CampaignMap: map created');
              _mapController = controller;
            },
            markers: campaigns
                .map((campaign) {
                  print('CampaignMap: creating marker for campaign ${campaign.id}');
                  return Marker(
                    markerId: MarkerId(campaign.id),
                    position:
                        LatLng(campaign.locationLat, campaign.locationLng),
                    infoWindow: InfoWindow(
                      title: campaign.title,
                      snippet:
                          '\$${campaign.targetAmount.toStringAsFixed(2)} goal',
                    ),
                    onTap: () => _showCampaignDetails(context, campaign),
                  );
                })
                .toSet(),
          );
        },
        loading: () {
          print('CampaignMap: showing loading state');
          return const Center(child: CircularProgressIndicator());
        },
        error: (error, stack) {
          print('CampaignMap: error state: $error');
          print('CampaignMap: error stack: $stack');
          return Center(child: Text('Error: $error'));
        },
      ),
    );
  }
}
