import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/campaigns/presentation/screens/campaign_list_screen.dart';
import '../../features/campaigns/presentation/screens/campaign_map_screen.dart';
import '../../features/campaigns/presentation/screens/create_campaign_screen.dart';
import '../../features/campaigns/presentation/screens/campaign_details_screen.dart';
import './navigation_providers.dart';

class MainNavigationLayout extends ConsumerWidget {
  const MainNavigationLayout({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentScreen = ref.watch(mainScreenProvider);

    debugPrint('Current mainScreenProvider state: $currentScreen');

    Widget body;
    switch (currentScreen) {
      case MainScreen.home:
        body = const CampaignListScreen();
        break;
      case MainScreen.map:
        body = const CampaignMapScreen();
        break;
      case MainScreen.campaignDetails:
        final campaignId = ref.watch(campaignIdProvider);
        debugPrint('Navigating to CampaignDetailsScreen with ID: $campaignId');
        debugPrint(
            'campaignIdProvider value in MainNavigationLayout: ${ref.watch(campaignIdProvider)}');

        body = campaignId != null
            ? CampaignDetailsScreen(campaignId: campaignId)
            : const Center(child: Text('No campaign selected.'));
        break;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mutual Aid Connect'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const CreateCampaignScreen(),
                ),
              );
            },
            tooltip: 'Create Campaign',
          ),
        ],
      ),
      body: body,
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Map',
          ),
        ],
        currentIndex: currentScreen == MainScreen.map ? 1 : 0,
        onTap: (index) {
          final selectedScreen = index == 0 ? MainScreen.home : MainScreen.map;
          ref.read(mainScreenProvider.notifier).state = selectedScreen;
        },
      ),
    );
  }
}
