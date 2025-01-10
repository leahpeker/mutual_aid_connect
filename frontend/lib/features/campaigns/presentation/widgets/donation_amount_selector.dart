import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/features/campaigns/presentation/providers/donation_providers.dart';

class DonationAmountSelector extends ConsumerWidget {

  static const List<int> defaultAmounts = [10, 20, 50, 100];

  const DonationAmountSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedAmount = ref.watch(selectedAmountProvider);
    // final customAmountController = TextEditingController(
    //   text: ref.watch(customAmountProvider),
    // );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Donate Amount:',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: defaultAmounts.map((amount) {
            return ChoiceChip(
              label: Text('\$$amount'),
              selected: selectedAmount == amount.toDouble(),
              onSelected: (selected) {
                ref.read(selectedAmountProvider.notifier).setAmount(selected ? amount.toDouble() : null);
                ref.read(customAmountProvider.notifier).reset();
              },
            );
          }).toList(),
        ),
        const SizedBox(height: 8),
        TextField(
          // controller: customAmountController,
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          decoration: const InputDecoration(
            labelText: 'Custom Amount',
            prefixText: '\$',
            border: OutlineInputBorder(),
          ),
          onChanged: (value) {
            ref.read(selectedAmountProvider.notifier).reset();
            final parsedAmount = double.tryParse(value); // Parse custom amount safely
            if (parsedAmount != null) {
              ref.read(customAmountProvider.notifier).setAmount(parsedAmount); // Set custom amount
            } else {
              ref.read(customAmountProvider.notifier).reset();
            }
          },
        ),
      ],
    );
  }
}


