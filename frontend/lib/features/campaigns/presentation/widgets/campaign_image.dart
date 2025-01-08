import 'package:flutter/material.dart';

class CampaignImage extends StatelessWidget {
  final String? imageUrl;

  const CampaignImage({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return imageUrl != null
        ? Image.network(imageUrl!)
        : const Placeholder(
            fallbackHeight: 200,
            fallbackWidth: double.infinity,
          );
  }
}
