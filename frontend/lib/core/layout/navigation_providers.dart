import 'package:flutter_riverpod/flutter_riverpod.dart';

// Enum for screen types
enum MainScreen { home, map, campaignDetails, donation }

// Navigation state provider
final mainScreenProvider = StateProvider<MainScreen>((ref) => MainScreen.home);

// Campaign ID provider for the details screen
final campaignIdProvider = StateProvider<String?>((ref) => null);

final donationCampaignIdProvider = StateProvider<String?>((ref) => null);

