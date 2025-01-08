import 'package:flutter/material.dart';
import '../../domain/models/campaign.dart';
import 'campaign_image.dart';

class CampaignDetailsContent extends StatelessWidget {
  final Campaign campaign;

  const CampaignDetailsContent({super.key, required this.campaign});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            campaign.title,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          CampaignImage(imageUrl: campaign.imageUrl),
          const SizedBox(height: 8),
          Text(
            campaign.description,
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 16),
          Text(
            'Target Amount: \$${campaign.targetAmount.toStringAsFixed(2)}',
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 16),
          Text(
            'Ends At: ${campaign.endsAt.toLocal()}',
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 16),
          Text(
            'Location: (${campaign.locationLat}, ${campaign.locationLng})',
            style: const TextStyle(fontSize: 16),
          ),

        ],
      ),
    );
  }
}
