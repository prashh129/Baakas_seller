import 'dart:ui';
import 'package:baakas_seller/features/shop/screens/checkout/checkout.dart';
import 'package:baakas_seller/utils/constants/image_strings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class EsewaPaymentScreen extends StatefulWidget {
  final double amount;

  const EsewaPaymentScreen({super.key, required this.amount});

  @override
  State<EsewaPaymentScreen> createState() => _EsewaPaymentScreenState();
}

class _EsewaPaymentScreenState extends State<EsewaPaymentScreen> {
  final _formKey = GlobalKey<FormState>();
  final _esewaIdController = TextEditingController();
  final _passwordController = TextEditingController();
  final _logger = Logger();
  bool _isLoading = false;

  // Function to handle the payment process
  void _handlePayment() async {
    // Validate the form before proceeding
    if (!_formKey.currentState!.validate()) return;

    FocusScope.of(context).unfocus(); // Hide keyboard
    setState(() => _isLoading = true);

    final success = await _fakeApiCall(
      _esewaIdController.text.trim(),
      _passwordController.text,
    );

    setState(() => _isLoading = false);

    if (success) {
      _showDialog(
        title: "Payment Successful",
        message: "Your payment was completed via eSewa.",
        isSuccess: true,
        onConfirm: () async {
          await _savePaymentRecord(true);
          Get.to(() => const CheckoutScreen());
        },
      );
    } else {
      _showDialog(
        title: "Transaction Failed",
        message: "Invalid eSewa ID or password. Please try again.",
        isSuccess: false,
      );
    }
  }

  // Show confirmation dialog before proceeding with the payment
  void _showConfirmationDialog() {
    FocusScope.of(context).requestFocus(FocusNode()); // Dismiss keyboard

    // Only show the confirmation dialog after form validation
    if (!_formKey.currentState!.validate()) return;

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text("Confirm Payment"),
            content: const Text(
              "Are you sure you want to continue with the eSewa payment?",
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text("Cancel"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _handlePayment(); // Proceed with the payment after confirmation
                },
                child: const Text(
                  "Yes, Continue",
                  style: TextStyle(color: Colors.green),
                ),
              ),
            ],
          ),
    );
  }

  // Fake API call for validation (simulate network delay)
  Future<bool> _fakeApiCall(String id, String password) async {
    await Future.delayed(const Duration(seconds: 2));
    return id == "demo" && password == "1234";
  }

  // Save payment record in Firestore
  Future<void> _savePaymentRecord(bool isSuccess) async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        _showDialog(
          title: "Not Logged In",
          message: "Please log in to complete the payment.",
          isSuccess: false,
        );
        return;
      }

      await FirebaseFirestore.instance.collection('esewa_payments').add({
        'esewaId': _esewaIdController.text.trim(),
        'userId': user.uid,
        'amount': widget.amount, // Actual amount from checkout
        'status': isSuccess ? 'success' : 'failed',
        'method': 'eSewa',
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      _logger.e("Error saving payment record: $e");
    }
  }

  // Show dialog for payment success or failure
  void _showDialog({
    required String title,
    required String message,
    required bool isSuccess,
    VoidCallback? onConfirm,
  }) {
    FocusScope.of(context).unfocus(); // Ensure keyboard stays hidden

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Row(
              children: [
                Icon(
                  isSuccess ? Icons.check_circle : Icons.error,
                  color: isSuccess ? Colors.green : Colors.red,
                ),
                const SizedBox(width: 8),
                Text(title),
              ],
            ),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  if (onConfirm != null) onConfirm();
                  FocusScope.of(
                    context,
                  ).requestFocus(FocusNode()); // Keep keyboard hidden
                },
                child: const Text("OK"),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: const Text("eSewa Payment"),
            backgroundColor: Colors.transparent,
            elevation: 0,
            iconTheme: IconThemeData(
              color:
                  brightness == Brightness.dark ? Colors.white : Colors.black,
            ),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Image.asset(BaakasImages.esewaPay, height: 100),
                const SizedBox(height: 30),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _esewaIdController,
                        decoration: const InputDecoration(
                          labelText: 'eSewa ID',
                          border: OutlineInputBorder(),
                        ),
                        validator:
                            (value) =>
                                value!.isEmpty ? 'Enter your eSewa ID' : null,
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(),
                        ),
                        validator:
                            (value) =>
                                value!.isEmpty ? 'Enter your password' : null,
                      ),
                      const SizedBox(height: 30),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed:
                              _isLoading ? null : _showConfirmationDialog,
                          child: const Text("Pay Now"),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        if (_isLoading)
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
              child: Container(
                color: Colors.black.withOpacity(0.4),
                child: const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
