import 'package:flutter/material.dart';
import '../models/campaign.dart';
import '../core/theme/app_theme.dart';

class CampaignsListView extends StatelessWidget {
  // Temporary dummy data - later this would come from your backend
  final List<Campaign> campaigns = [
    Campaign(
      id: '1',
      title: 'Community Food Drive',
      description: 'Help us provide food for families in need in our local community.',
      organizer: 'Local Food Bank',
      goalAmount: 5000.0,
      currentAmount: 2500.0,
      createdAt: DateTime.now(),
      imageUrl: 'https://images.unsplash.com/photo-1488521787991-ed7bbaae773c?w=800',  // Food bank image
    ),
    Campaign(
      id: '2',
      title: 'Emergency Housing Support',
      description: 'Supporting families facing housing insecurity.',
      organizer: 'Housing First Coalition',
      goalAmount: 10000.0,
      currentAmount: 3000.0,
      createdAt: DateTime.now(),
      imageUrl: 'https://images.unsplash.com/photo-1560518883-ce09059eeffa?w=800',  // Housing image
    ),
    Campaign(
      id: '3',
      title: 'Youth Education Fund',
      description: 'Supporting after-school programs for underprivileged youth.',
      organizer: 'Education For All',
      goalAmount: 7500.0,
      currentAmount: 4200.0,
      createdAt: DateTime.now(),
      imageUrl: 'https://images.unsplash.com/photo-1503676260728-1c00da094a0b?w=800',  // Education image
    ),
  ];

  CampaignsListView({super.key});

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
          final campaign = campaigns[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 8.0),
            color: Colors.grey[900],
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Campaign Image
                AspectRatio(
                  aspectRatio: 1.0,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey[800],
                      image: DecorationImage(
                        image: NetworkImage(campaign.imageUrl),  // Changed to NetworkImage
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                
                // Campaign Meta Data
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title and Progress
                      Text(
                        campaign.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${((campaign.currentAmount / campaign.goalAmount) * 100).toInt()}% funded',
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 12),
                      
                      // Donor Info Row with Support Button
                      Row(
                        children: [
                          // Stacked Donor Avatars
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
                                // Navigate to campaign details
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
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
} 