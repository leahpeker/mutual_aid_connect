import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import '../../domain/models/campaign.dart';
import '../providers/campaign_provider.dart';
import 'campaign_card.dart';


class CampaignList extends ConsumerWidget {
  const CampaignList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final campaignsAsync = ref.watch(campaignNotifierProvider);

    return campaignsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
      data: (campaigns) => ListView.builder(
        itemCount: campaigns.length,
        itemBuilder: (context, index) {
          final campaign = campaigns[index];
          return CampaignCard(campaign: campaign);
        },
      ),
    );
  }
}
