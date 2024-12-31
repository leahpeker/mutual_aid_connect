import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/repositories/campaign_repository.dart';
import '../../domain/models/campaign.dart';

part 'campaign_provider.g.dart';

@riverpod
class CampaignNotifier extends _$CampaignNotifier {
  late final CampaignRepository _repository = CampaignRepository();

  @override
  FutureOr<List<Campaign>> build() async {
    return _repository.getCampaigns();
  }
} 