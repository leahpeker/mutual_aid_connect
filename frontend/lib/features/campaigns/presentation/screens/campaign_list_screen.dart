import 'package:flutter/material.dart';
import '../../domain/campaign.dart';
import '../widgets/campaign_card.dart';

class CampaignListScreen extends StatelessWidget {
  // Temporary dummy data - later this would come from your repository
  final List<Campaign> campaigns = [
Campaign(
      id: '1',
      title: 'Community Food Drive',
      description:
          'Help us provide food for families in need in our local community.',
      organizer: 'Local Food Bank',
      goalAmount: 5000.0,
      currentAmount: 2500.0,
      createdAt: DateTime.now(),
      imageUrl:
          'https://images.unsplash.com/photo-1488521787991-ed7bbaae773c?w=800', // Food bank image
    ),
    Campaign(
      id: '2',
      title: 'Emergency Housing Support',
      description: 'Supporting families facing housing insecurity.',
      organizer: 'Housing First Coalition',
      goalAmount: 10000.0,
      currentAmount: 3000.0,
      createdAt: DateTime.now(),
      imageUrl:
          'https://images.unsplash.com/photo-1560518883-ce09059eeffa?w=800', // Housing image
    ),
    Campaign(
      id: '3',
      title: 'Youth Education Fund',
      description:
          'Supporting after-school programs for underprivileged youth.',
      organizer: 'Education For All',
      goalAmount: 7500.0,
      currentAmount: 4200.0,
      createdAt: DateTime.now(),
      imageUrl:
          'https://images.unsplash.com/photo-1503676260728-1c00da094a0b?w=800', // Education image
    ),
  ];

  CampaignListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mutual Aid Connect'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.only(top: 8.0),
        itemCount: campaigns.length,
        itemBuilder: (context, index) {
          return CampaignCard(campaign: campaigns[index]);
        },
      ),
    );
  }
}
