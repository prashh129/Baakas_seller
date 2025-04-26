import 'dart:ui';
import 'package:baakas_seller/features/shop/controllers/product/cart_controller.dart';
import 'package:baakas_seller/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';

class CreditCardDetailsScreen extends StatefulWidget {
  const CreditCardDetailsScreen({super.key});

  @override
  State<CreditCardDetailsScreen> createState() =>
      _CreditCardDetailsScreenState();
}

class _CreditCardDetailsScreenState extends State<CreditCardDetailsScreen> {
  final _logger = Logger();
  final _formKey = GlobalKey<FormState>();
  final _cardNumberController = TextEditingController();
  final _expiryController = TextEditingController();
  final _cvvController = TextEditingController();
  final _nameController = TextEditingController();

  bool _isProcessing = false;
  String _cardType = '';

  @override
  void initState() {
    super.initState();
    if (!Get.isRegistered<CartController>()) {
      Get.put(CartController());
    }

    _cardNumberController.addListener(() => setState(() => _detectCardType()));
    _expiryController.addListener(() => setState(() {}));
    _cvvController.addListener(() => setState(() {}));
    _nameController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _cardNumberController.dispose();
    _expiryController.dispose();
    _cvvController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  void _detectCardType() {
    final number = _cardNumberController.text.replaceAll(' ', '');
    setState(() {
      if (number.startsWith('4')) {
        _cardType = 'VISA';
      } else if (number.startsWith('5')) {
        _cardType = 'MasterCard';
      } else if (number.startsWith('34') || number.startsWith('37')) {
        _cardType = 'AMEX';
      } else {
        _cardType = '';
      }
    });
  }

  String formatCardNumber(String input) {
    return input.replaceAllMapped(
      RegExp(r".{1,4}"),
      (match) => "${match.group(0)} ",
    );
  }

  Future<void> _showConfirmationPopup() async {
    bool shouldProceed =
        await showDialog(
          context: context,
          builder:
              (_) => AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                title: const Text("Confirm Payment"),
                content: const Text(
                  "Are you sure you want to continue with the payment?",
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: const Text("Cancel"),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: const Text("Proceed"),
                  ),
                ],
              ),
        ) ??
        false;

    if (shouldProceed) {
      _handlePayment();
    }
  }

  Future<void> _handlePayment() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isProcessing = true);

    await Future.delayed(const Duration(seconds: 2)); // Simulate payment

    bool isValid =
        _cardNumberController.text.replaceAll(' ', '') == '4111111111111111' &&
        _cvvController.text == '123' &&
        _expiryController.text == '12/25';

    setState(() => _isProcessing = false);

    _showPopup(
      title: isValid ? "Transaction Successful" : "Transaction Failed",
      message:
          isValid
              ? "Your payment has been processed successfully."
              : "Invalid card details. Please try again.",
      isSuccess: isValid,
    );

    if (isValid) {
      // Save the payment data to Firestore
      savePaymentData();
    }
  }

  Future<void> savePaymentData() async {
    try {
      final paymentData = {
        'card_number': '4111111111111111',
        'card_type': 'VISA',
        'cardholder_name': 'dddd',
        'cvv': '123',
        'expiry_date': '12/25',
        'payment_method': 'CreditCard',
        'timestamp': FieldValue.serverTimestamp(),
        'userId': 'ZLKzKYq5doV9pRip8QNWpevXQ1o2',
        'amount': CartController.instance.totalCartPrice.value,
      };

      await FirebaseFirestore.instance
          .collection('credit_payments')
          .add(paymentData);

      _logger.i("Payment data saved successfully.");
    } catch (e) {
      _logger.e("Error saving payment data: $e");
    }
  }

  void _showPopup({
    required String title,
    required String message,
    required bool isSuccess,
  }) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder:
          (_) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            title: Row(
              children: [
                Icon(
                  isSuccess ? Icons.check_circle : Icons.error,
                  color: isSuccess ? Colors.green : Colors.red,
                ),
                const SizedBox(width: 10),
                Text(title),
              ],
            ),
            content: Text(message),
            actions: [
              TextButton(
                child: const Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                  if (isSuccess) {
                    Get.toNamed('/checkout');
                  }
                },
              ),
            ],
          ),
    );
  }


  @override
  Widget build(BuildContext context) {
    final cardNumber = _cardNumberController.text;
    final expiry = _expiryController.text;
    final cvv = _cvvController.text;
    final name = _nameController.text;

    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: const Text("Credit Card Payment"),
            iconTheme: IconThemeData(
              color:
                  Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black,
            ),
          ),
          body: WillPopScope(
            onWillPop: () async => !_isProcessing,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 200,
                    padding: const EdgeInsets.all(20),
                    margin: const EdgeInsets.only(bottom: 24),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: const LinearGradient(
                        colors: [Colors.teal, Colors.green],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _cardType.isEmpty ? 'CREDIT CARD' : _cardType,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          cardNumber.isEmpty
                              ? '#### #### #### ####'
                              : formatCardNumber(cardNumber),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            letterSpacing: 1.5,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              expiry.isEmpty ? 'MM/YY' : expiry,
                              style: const TextStyle(color: Colors.white),
                            ),
                            Text(
                              cvv.isEmpty ? 'CVV' : '***',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          name.isEmpty ? 'Cardholder Name' : name,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        _buildTextField(
                          controller: _cardNumberController,
                          label: 'Card Number',
                          hint: '#### #### #### ####',
                          icon: Icons.credit_card,
                          keyboardType: TextInputType.number,
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: _buildTextField(
                                controller: _expiryController,
                                label: 'Expiry',
                                hint: 'MM/YY',
                                icon: Icons.calendar_month,
                                keyboardType: TextInputType.datetime,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: _buildTextField(
                                controller: _cvvController,
                                label: 'CVV',
                                hint: '***',
                                icon: Icons.lock,
                                keyboardType: TextInputType.number,
                                obscureText: true,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        _buildTextField(
                          controller: _nameController,
                          label: 'Cardholder Name',
                          hint: 'John Doe',
                          icon: Icons.person,
                        ),
                        const SizedBox(height: BaakasSizes.spaceBtwSections),
                        const SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _showConfirmationPopup();
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text(
                              "Pay Now",
                              style: TextStyle(fontSize: 16),
                            ),
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
        if (_isProcessing)
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

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType? keyboardType,
    bool obscureText = false,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        labelText: label,
        hintText: hint,
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black26),
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black26),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.green),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      validator:
          (value) => value == null || value.isEmpty ? 'Enter $label' : null,
    );
  }
}
