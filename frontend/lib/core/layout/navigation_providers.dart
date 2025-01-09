import 'package:flutter_riverpod/flutter_riverpod.dart';

// Enum for screen types
enum MainScreen { home, map, campaignDetails }

// Navigation state provider
final mainScreenProvider = StateProvider<MainScreen>((ref) => MainScreen.home);

// Campaign ID provider for the details screen
final campaignIdProvider = StateProvider<String?>((ref) => null);
