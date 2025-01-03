import 'package:flutter/material.dart';
import '../widgets/campaign_map.dart';

class CampaignMapScreen extends StatelessWidget {
  const CampaignMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Campaign Map'),
      ),
      body: CampaignMap(),
    );
  }
}
