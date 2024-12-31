import 'package:flutter/material.dart';
import '../widgets/campaign_list.dart';

class CampaignListScreen extends StatelessWidget {
  const CampaignListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mutual Aid Connect'),
      ),
      body: const CampaignList(),
    );
  }
}
