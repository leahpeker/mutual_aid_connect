import 'package:flutter/material.dart';
import 'package:frontend/features/campaigns/data/providers/campaign_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/layout/navigation_providers.dart';
import '../providers/campaign_form_provider.dart';

class CreateCampaignForm extends ConsumerWidget {
  const CreateCampaignForm({super.key});

  Future<void> _selectDateTime(BuildContext context, WidgetRef ref) async {
    final formNotifier = ref.read(campaignFormProvider.notifier);

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      final pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        formNotifier.updateEndsAt(DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        ));
      }
    }
  }

  Future<void> _onSubmit(BuildContext context, WidgetRef ref) async {
    final formState = ref.read(campaignFormProvider);
    final formNotifier = ref.read(campaignFormProvider.notifier);

    if (formState.title.isEmpty ||
        formState.description.isEmpty ||
        formState.targetAmount.isEmpty ||
        formState.locationLat.isEmpty ||
        formState.locationLng.isEmpty ||
        formState.endsAt == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }

    final targetAmount = double.tryParse(formState.targetAmount);
    if (targetAmount == null || targetAmount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enter a valid target amount')),
      );
      return;
    }

    const imageUrl =
        "https://images.unsplash.com/photo-1514320291840-2e0a9bf2a9ae";

    try {
      final createdCampaign =
          await ref.read(campaignRepositoryProvider).createCampaign(
                title: formState.title,
                description: formState.description,
                targetAmount: targetAmount,
                locationLat: double.parse(formState.locationLat),
                locationLng: double.parse(formState.locationLng),
                endsAt: formState.endsAt!,
                imageUrl: imageUrl,
              );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Campaign created successfully!')),
      );

      ref.read(campaignIdProvider.notifier).state = createdCampaign.id;
      ref.read(mainScreenProvider.notifier).state = MainScreen.campaignDetails;

      formNotifier.resetForm();
      Navigator.of(context).pop();
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${error.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formState = ref.watch(campaignFormProvider);
    final formNotifier = ref.read(campaignFormProvider.notifier);

    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            initialValue: formState.title,
            decoration: const InputDecoration(labelText: 'Title'),
            onChanged: formNotifier.updateTitle,
          ),
          TextFormField(
            initialValue: formState.description,
            decoration: const InputDecoration(labelText: 'Description'),
            maxLines: 3,
            onChanged: formNotifier.updateDescription,
          ),
          TextFormField(
            initialValue: formState.targetAmount,
            decoration: const InputDecoration(labelText: 'Target Amount'),
            keyboardType: TextInputType.number,
            onChanged: formNotifier.updateTargetAmount,
          ),
          TextFormField(
            initialValue: formState.locationLat,
            decoration: const InputDecoration(labelText: 'Location Lat'),
            keyboardType: TextInputType.number,
            onChanged: formNotifier.updateLocationLat,
          ),
          TextFormField(
            initialValue: formState.locationLng,
            decoration: const InputDecoration(labelText: 'Location Lng'),
            keyboardType: TextInputType.number,
            onChanged: formNotifier.updateLocationLng,
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Ends At',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    formState.endsAt == null
                        ? 'Select date and time'
                        : '${formState.endsAt!.toLocal()}',
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () => _selectDateTime(context, ref),
                child: const Text('Pick Date & Time'),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => _onSubmit(context, ref),
            child: const Text('Create Campaign'),
          ),
        ],
      ),
    );
  }
}
