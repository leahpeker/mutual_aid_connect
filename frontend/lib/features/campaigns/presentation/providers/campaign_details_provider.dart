import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/features/campaigns/data/providers/campaign_repository_provider.dart';
import '../../domain/models/campaign.dart';

final campaignDetailsProvider =
    FutureProvider.family<Campaign, String>((ref, campaignId) async {
  final repository = ref.read(campaignRepositoryProvider);
  return await repository.getCampaignById(campaignId);
});
