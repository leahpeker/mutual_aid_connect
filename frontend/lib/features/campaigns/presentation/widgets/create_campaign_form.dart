import 'package:flutter/material.dart';
import 'package:frontend/features/campaigns/data/providers/campaign_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class CreateCampaignForm extends ConsumerStatefulWidget {
  const CreateCampaignForm({super.key});

  @override
  ConsumerState<CreateCampaignForm> createState() => _CreateCampaignFormState();
}

class _CreateCampaignFormState extends ConsumerState<CreateCampaignForm> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for input fields
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _targetAmountController = TextEditingController();
  final _locationLatController = TextEditingController();
  final _locationLngController = TextEditingController();

  // Date and time picker values
  DateTime? _selectedEndDateTime;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _targetAmountController.dispose();
    _locationLatController.dispose();
    _locationLngController.dispose();
    super.dispose();
  }

  Future<void> _selectDateTime(BuildContext context) async {
    // Pick a date
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      // Pick a time
      final pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        setState(() {
          _selectedEndDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
      }
    }
  }

  Future<void> _onSubmit() async {
    if (_formKey.currentState!.validate()) {
      final title = _titleController.text.trim();
      final description = _descriptionController.text.trim();
      final targetAmount = double.tryParse(_targetAmountController.text.trim());
      final locationLat = double.tryParse(_locationLatController.text.trim());
      final locationLng = double.tryParse(_locationLngController.text.trim());

      if (_selectedEndDateTime == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select an end date and time.')),
        );
        return;
      }

      if (targetAmount == null || targetAmount <= 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Enter a valid target amount.')),
        );
        return;
      }

      

      const imageUrl = "https://via.placeholder.com/150";

      try {
        // Use ref.read inside the ConsumerState class context
        await ref.read(campaignRepositoryProvider).createCampaign(
              title: title,
              description: description,
              targetAmount: targetAmount,
              locationLat: locationLat!,
              locationLng: locationLng!,
              endsAt: _selectedEndDateTime!,
              imageUrl: imageUrl,
            );

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Campaign created successfully!')),
        );

        // Clear form after success
        _formKey.currentState!.reset();
        setState(() {
          _selectedEndDateTime = null;
        });
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${error.toString()}')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: _titleController,
            decoration: const InputDecoration(labelText: 'Title'),
            validator: (value) =>
                value == null || value.isEmpty ? 'Title is required' : null,
          ),
          TextFormField(
            controller: _descriptionController,
            decoration: const InputDecoration(labelText: 'Description'),
            maxLines: 3,
            validator: (value) => value == null || value.isEmpty
                ? 'Description is required'
                : null,
          ),
          TextFormField(
            controller: _targetAmountController,
            decoration: const InputDecoration(labelText: 'Target Amount'),
            keyboardType: TextInputType.number,
            validator: (value) => value == null || value.isEmpty
                ? 'Target amount is required'
                : double.tryParse(value) == null
                    ? 'Enter a valid number'
                    : null,
          ),
          TextFormField(
            controller: _locationLatController,
            decoration: const InputDecoration(labelText: 'Location Lat'),
            validator: (value) =>
                value == null || value.isEmpty ? 'Location is required' : null,
          ),
          TextFormField(
            controller: _locationLngController,
            decoration: const InputDecoration(labelText: 'Location Lng'),
            validator: (value) =>
                value == null || value.isEmpty ? 'Location is required' : null,
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
                    _selectedEndDateTime == null
                        ? 'Select date and time'
                        : '${_selectedEndDateTime!.toLocal()}',
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () => _selectDateTime(context),
                child: const Text('Pick Date & Time'),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _onSubmit,
            child: const Text('Create Campaign'),
          ),
        ],
      ),
    );
  }
}

