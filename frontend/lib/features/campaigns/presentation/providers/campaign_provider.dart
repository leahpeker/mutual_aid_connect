import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/models/campaign.dart';
import '../../data/providers/campaign_repository_provider.dart';

part 'campaign_provider.g.dart';

@riverpod
class CampaignNotifier extends _$CampaignNotifier {
  @override
  FutureOr<List<Campaign>> build() async {
    final repository = ref.watch(campaignRepositoryProvider);
    return repository.getCampaigns();
  }
}
