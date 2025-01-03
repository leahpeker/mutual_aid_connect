import 'package:riverpod/riverpod.dart';
import '../repositories/campaign_repository.dart';

/// A provider for the CampaignRepository
final campaignRepositoryProvider = Provider<CampaignRepository>((ref) {
  return CampaignRepository();
});
