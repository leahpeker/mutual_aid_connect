import 'package:flutter/material.dart';
import '../../../campaigns/presentation/screens/campaign_list_screen.dart';
import '../../../campaigns/presentation/screens/campaign_map_screen.dart';
import '../../../campaigns/presentation/screens/create_campaign_screen.dart';

class MainNavigationLayout extends StatefulWidget {
  const MainNavigationLayout({super.key});

  @override
  State<MainNavigationLayout> createState() => _MainNavigationLayoutState();
}

class _MainNavigationLayoutState extends State<MainNavigationLayout> {
  int _selectedIndex = 0;

  static final List<Widget> _screens = [
    CampaignListScreen(),
    CampaignMapScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

void _onCreateCampaign() {
  Navigator.of(context).push(
    MaterialPageRoute(builder: (context) => const CreateCampaignScreen()),
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mutual Aid Connect'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _onCreateCampaign,
            tooltip: 'Create Campaign',
          ),
        ],
      ),
      
      body: _screens[_selectedIndex],
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
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
