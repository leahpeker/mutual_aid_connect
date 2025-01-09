import 'package:flutter_riverpod/flutter_riverpod.dart';

// Define the campaign form state
class CampaignFormState {
  final String title;
  final String description;
  final String targetAmount;
  final String locationLat;
  final String locationLng;
  final DateTime? endsAt;

  const CampaignFormState({
    this.title = '',
    this.description = '',
    this.targetAmount = '',
    this.locationLat = '',
    this.locationLng = '',
    this.endsAt,
  });

  // Copy the state with updated values
  CampaignFormState copyWith({
    String? title,
    String? description,
    String? targetAmount,
    String? locationLat,
    String? locationLng,
    DateTime? endsAt,
  }) {
    return CampaignFormState(
      title: title ?? this.title,
      description: description ?? this.description,
      targetAmount: targetAmount ?? this.targetAmount,
      locationLat: locationLat ?? this.locationLat,
      locationLng: locationLng ?? this.locationLng,
      endsAt: endsAt ?? this.endsAt,
    );
  }
}

// Define a StateNotifier to manage the CampaignFormState
class CampaignFormNotifier extends StateNotifier<CampaignFormState> {
  CampaignFormNotifier() : super(const CampaignFormState());

  void updateTitle(String title) => state = state.copyWith(title: title);
  void updateDescription(String description) =>
      state = state.copyWith(description: description);
  void updateTargetAmount(String targetAmount) =>
      state = state.copyWith(targetAmount: targetAmount);
  void updateLocationLat(String locationLat) =>
      state = state.copyWith(locationLat: locationLat);
  void updateLocationLng(String locationLng) =>
      state = state.copyWith(locationLng: locationLng);
  void updateEndsAt(DateTime? endsAt) => state = state.copyWith(endsAt: endsAt);

  void resetForm() => state = const CampaignFormState();
}

// Create the provider
final campaignFormProvider =
    StateNotifierProvider<CampaignFormNotifier, CampaignFormState>(
        (ref) => CampaignFormNotifier());
