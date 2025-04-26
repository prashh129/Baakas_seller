import 'dart:ui';
import 'package:baakas_seller/features/shop/screens/checkout/checkout.dart';
import 'package:baakas_seller/utils/constants/image_strings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class KhaltiPaymentScreen extends StatefulWidget {
  final double amount; // ✅ Added to receive actual checkout amount

  const KhaltiPaymentScreen({super.key, required this.amount});

  @override
  State<KhaltiPaymentScreen> createState() => _KhaltiPaymentScreenState();
}

class _KhaltiPaymentScreenState extends State<KhaltiPaymentScreen> {
  final _formKey = GlobalKey<FormState>();
  final _khaltiIdController = TextEditingController();
  final _passwordController = TextEditingController();
  final _logger = Logger();

  bool _isLoading = false;

  void _handlePayment() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final success = await _fakeApiCall(
      _khaltiIdController.text.trim(),
      _passwordController.text,
    );

    setState(() => _isLoading = false);

    if (success) {
      _showDialog(
        title: "Payment Successful",
        message: "Your payment was completed via Khalti.",
        isSuccess: true,
        onConfirm: () async {
          await _savePaymentRecord(true);
          Get.to(() => const CheckoutScreen());
        },
      );
    } else {
      _showDialog(
        title: "Transaction Failed",
        message: "Invalid Khalti ID or password. Please try again.",
        isSuccess: false,
      );
    }
  }

  void _showConfirmationDialog() {
    FocusScope.of(context).requestFocus(FocusNode()); // Hide keyboard

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm Payment"),
          content: const Text(
            "Are you sure you want to continue with the Khalti payment?",
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _handlePayment();
              },
              child: const Text(
                "Yes, Continue",
                style: TextStyle(color: Colors.green),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<bool> _fakeApiCall(String id, String password) async {
    await Future.delayed(const Duration(seconds: 2));
    return id == "demo" && password == "1234";
  }

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

      final userId = user.uid;

      await FirebaseFirestore.instance.collection('khalti_payments').add({
        'khaltiId': _khaltiIdController.text.trim(),
        'userId': userId,
        'amount': widget.amount, // ✅ Dynamic checkout amount saved
        'status': isSuccess ? 'success' : 'failed',
        'method': 'Khalti',
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      _logger.e("Error saving payment record to Firestore: $e");
    }
  }

  void _showDialog({
    required String title,
    required String message,
    required bool isSuccess,
    VoidCallback? onConfirm,
  }) {
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
            title: const Text("Khalti Payment"),
            iconTheme: IconThemeData(
              color:
                  brightness == Brightness.dark ? Colors.white : Colors.black,
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(BaakasImages.khaltiPay, height: 100),
                    const SizedBox(height: 30),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _khaltiIdController,
                            decoration: const InputDecoration(
                              labelText: 'Khalti ID',
                              border: OutlineInputBorder(),
                            ),
                            validator:
                                (value) =>
                                    value!.isEmpty
                                        ? 'Enter your Khalti ID'
                                        : null,
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
                                    value!.isEmpty
                                        ? 'Enter your password'
                                        : null,
                          ),
                          const SizedBox(height: 30),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: _showConfirmationDialog,
                              child: const Text("Pay with Khalti"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        if (_isLoading)
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 6.0, sigmaY: 6.0),
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
