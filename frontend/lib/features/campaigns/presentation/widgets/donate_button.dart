import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/features/campaigns/presentation/providers/donation_providers.dart';

class DonateButton extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedAmount = ref.watch(selectedAmountProvider);
    final customAmount = ref.watch(customAmountProvider);
    final paymentState = ref.watch(paymentNotifierProvider);

    double? getAmount() {
      if (selectedAmount != null) return selectedAmount.toDouble();
      final customValue = customAmount;
      return customValue != null && customValue > 0 ? customValue : null;
    }

    return ElevatedButton(
      onPressed: paymentState.isLoading
          ? null
          : () {
              final amount = getAmount();
              if (amount != null) {
                ref.read(paymentNotifierProvider.notifier).makePayment(amount);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Please enter a valid amount.')),
                );
              }
            },
      child: paymentState.isLoading
          ? const CircularProgressIndicator()
          : const Text('Donate'),
    );
  }
}
