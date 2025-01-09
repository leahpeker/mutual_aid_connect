import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/campaign_details_provider.dart';
import '../widgets/campaign_details_content.dart';

class CampaignDetailsScreen extends ConsumerWidget {
  final String campaignId;

  const CampaignDetailsScreen({Key? key, required this.campaignId})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final campaignAsyncValue = ref.watch(campaignDetailsProvider(campaignId));

    return Scaffold(
      body: campaignAsyncValue.when(
        data: (campaign) => CampaignDetailsContent(campaign: campaign),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
