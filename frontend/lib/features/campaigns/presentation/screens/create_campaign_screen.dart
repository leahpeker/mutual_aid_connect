import 'package:flutter/material.dart';
import '../widgets/create_campaign_form.dart';

class CreateCampaignScreen extends StatelessWidget {
  const CreateCampaignScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Campaign'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: CreateCampaignForm(),
      ),
    );
  }
}
