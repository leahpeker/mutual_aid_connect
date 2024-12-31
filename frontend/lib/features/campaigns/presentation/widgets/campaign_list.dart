import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/campaign.dart';
import '../providers/campaign_provider.dart';

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

class CampaignCard extends StatelessWidget {
  final Campaign campaign;

  const CampaignCard({super.key, required this.campaign});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(campaign.title),
        subtitle: Text(campaign.description),
        // Add more campaign details as needed
        onTap: () {
          // Handle campaign selection
        },
      ),
    );
  }
} 