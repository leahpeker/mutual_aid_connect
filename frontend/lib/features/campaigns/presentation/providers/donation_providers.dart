import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedAmountProvider = StateNotifierProvider<SelectedAmountNotifier, double?>((ref) {
  return SelectedAmountNotifier();
});

class SelectedAmountNotifier extends StateNotifier<double?> {
  SelectedAmountNotifier() : super(null); // Default value is null

  // Method to reset the amount to null
  void reset() {
    state = null;
  }

  // Method to set the amount to a new value
  void setAmount(double? amount) {
    state = amount;
  }
}


final customAmountProvider = StateNotifierProvider<CustomAmountNotifier, double?>((ref) {
  return CustomAmountNotifier();
});

class CustomAmountNotifier extends StateNotifier<double?> {
  CustomAmountNotifier() : super(null); // Default value is null

  // Method to reset the amount to null
  void reset() {
    state = null;
  }

  // Method to set the amount to a new value
  void setAmount(double? amount) {
    state = amount;
  }
}


final paymentNotifierProvider = NotifierProvider<PaymentNotifier, AsyncValue<void>>(
  PaymentNotifier.new,
);

class PaymentNotifier extends Notifier<AsyncValue<void>> {
  @override
  AsyncValue<void> build() {
    // Initialize the state as idle or empty
    return const AsyncData(null);
  }

  Future<void> makePayment(double amount) async {
    state = const AsyncLoading(); // Set state to loading
    try {
      // Replace this with your actual payment logic
      await Future.delayed(const Duration(seconds: 2)); // Simulate payment processing
      state = const AsyncData(null); // Payment successful
    } catch (e) {
      state = AsyncError(e, StackTrace.current); // Payment failed
    }
  }
}