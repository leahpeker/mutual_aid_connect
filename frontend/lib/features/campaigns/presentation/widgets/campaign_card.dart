import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/campaign.dart';
import '../../../../core/themes/app_theme.dart';
import '../../../../core/layout/navigation_providers.dart';

class CampaignCard extends ConsumerWidget {
  final Campaign campaign;

  const CampaignCard({super.key, required this.campaign});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8.0),
      color: Colors.grey[900],
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 1.0,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[800],
                image: campaign.imageUrl != null
                    ? DecorationImage(
                        image: NetworkImage(campaign.imageUrl!),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  campaign.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${((campaign.currentAmount / campaign.targetAmount) * 100).toInt()}% funded',
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 12),
                _buildDonorInfoRow(context, ref),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDonorInfoRow(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        SizedBox(
          width: 80,
          height: 32,
          child: Stack(
            children: List.generate(
              3,
              (index) => Positioned(
                left: index * 20.0,
                child: Container(
                  height: 32,
                  width: 32,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.black,
                      width: 2,
                    ),
                    color: Colors.grey[700],
                  ),
                  child: const Icon(
                    Icons.person,
                    size: 16,
                    color: AppTheme.accentGray,
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          '42 supporters',
          style: TextStyle(
            color: Colors.grey[400],
            fontSize: 14,
          ),
        ),
        const Spacer(),
        SizedBox(
          height: 36,
          child: ElevatedButton(
            onPressed: () {
              ref.read(donationCampaignIdProvider.notifier).state = campaign.id;
              ref.read(mainScreenProvider.notifier).state = MainScreen.donation;
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 0,
              ),
            ),
            child: const Text('Support'),
          ),
        ),
      ],
    );
  }
}
