import 'package:flutter/material.dart';
import '../../domain/models/campaign.dart';
import 'donation_details.dart';
import 'donation_amount_selector.dart';
import 'donate_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DonationModal extends ConsumerStatefulWidget {
  final Campaign campaign;

  const DonationModal({super.key, required this.campaign});

  @override
  _DonationModalState createState() => _DonationModalState();
}

class _DonationModalState extends ConsumerState<DonationModal>  with WidgetsBindingObserver {

  @override
  void initState() {
    super.initState();
    // Add observer to listen to app lifecycle changes
    WidgetsBinding.instance.addObserver(this);
  }



  @override
  Widget build(BuildContext context) {
      
      return SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DonationDetails(campaign: widget.campaign),
          const SizedBox(height: 16),
          DonationAmountSelector(),
          const SizedBox(height: 16),
          DonateButton(),
        ],
      ),
    );
  }
}
