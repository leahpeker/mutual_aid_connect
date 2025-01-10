import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/campaign_details_provider.dart';
import '../widgets/donation_modal.dart';

class DonationScreen extends ConsumerWidget {
  final String campaignId;

  const DonationScreen({super.key, required this.campaignId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final campaignAsyncValue = ref.watch(campaignDetailsProvider(campaignId));

    return Scaffold(
      body: campaignAsyncValue.when(
        data: (campaign) => DonationModal(campaign: campaign),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
