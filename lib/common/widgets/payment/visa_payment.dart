// import 'dart:ui';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:get/get.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:baakas/features/shop/controllers/product/cart_controller.dart';
// import 'package:baakas/features/shop/screens/checkout/checkout.dart';

// class VisaCardDetailsScreen extends StatefulWidget {
//   const VisaCardDetailsScreen({super.key});

//   @override
//   State<VisaCardDetailsScreen> createState() => _VisaCardDetailsScreenState();
// }

// class _VisaCardDetailsScreenState extends State<VisaCardDetailsScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _cardNumberController = TextEditingController();
//   final _expiryController = TextEditingController();
//   final _cvvController = TextEditingController();
//   final _nameController = TextEditingController();

//   bool _isProcessing = false;
//   String _cardType = '';

//   @override
//   void initState() {
//     super.initState();
//     _cardNumberController.addListener(_detectCardType);
//     _expiryController.addListener(() => setState(() {}));
//     _cvvController.addListener(() => setState(() {}));
//     _nameController.addListener(() => setState(() {}));
//     Get.put(CartController());
//   }

//   @override
//   void dispose() {
//     _cardNumberController.dispose();
//     _expiryController.dispose();
//     _cvvController.dispose();
//     _nameController.dispose();
//     super.dispose();
//   }

//   void _detectCardType() {
//     final number = _cardNumberController.text.replaceAll(' ', '');
//     setState(() {
//       if (number.startsWith('4')) {
//         _cardType = 'VISA';
//       } else if (number.startsWith('5')) {
//         _cardType = 'MasterCard';
//       } else if (number.startsWith('34') || number.startsWith('37')) {
//         _cardType = 'AMEX';
//       } else {
//         _cardType = '';
//       }
//     });
//   }

//   String formatCardNumber(String input) {
//     return input.replaceAllMapped(
//       RegExp(r".{1,4}"),
//       (match) => "${match.group(0)} ",
//     );
//   }

//   Future<void> _handleVisaPayment() async {
//     if (!_formKey.currentState!.validate()) return;

//     setState(() => _isProcessing = true);
//     await Future.delayed(const Duration(seconds: 2)); // Simulate processing

//     bool isValid =
//         _cardNumberController.text.replaceAll(' ', '') == '4111111111111111' &&
//         _cvvController.text == '123' &&
//         _expiryController.text == '12/25';

//     setState(() => _isProcessing = false);

//     if (isValid) {
//       try {
//         final user = FirebaseAuth.instance.currentUser;
//         final userId = user?.uid ?? 'anonymous';
//         final cartController = Get.find<CartController>();
//         final double checkoutAmount = cartController.totalCartPrice.value;

//         await FirebaseFirestore.instance.collection('visa_payments').add({
//           'card_number': _cardNumberController.text,
//           'expiry_date': _expiryController.text,
//           'cvv': _cvvController.text,
//           'cardholder_name': _nameController.text,
//           'card_type': _cardType,
//           'timestamp': FieldValue.serverTimestamp(),
//           'userId': userId,
//           'amount': checkoutAmount, // ✅ Added exact checkout amount
//         });
//       } catch (e) {
//         debugPrint('Error saving to Firestore: $e');
//       }
//     }

//     _showPopup(
//       title: isValid ? "Transaction Successful" : "Transaction Failed",
//       message:
//           isValid
//               ? "Your payment has been processed successfully."
//               : "Invalid card details. Please try again.",
//       isSuccess: isValid,
//     );
//   }

//   void _showPopup({
//     required String title,
//     required String message,
//     required bool isSuccess,
//   }) {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder:
//           (_) => AlertDialog(
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(15),
//             ),
//             title: Row(
//               children: [
//                 Icon(
//                   isSuccess ? Icons.check_circle : Icons.error,
//                   color: isSuccess ? Colors.green : Colors.red,
//                 ),
//                 const SizedBox(width: 10),
//                 Text(title),
//               ],
//             ),
//             content: Text(message),
//             actions: [
//               TextButton(
//                 child: const Text("OK"),
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                   if (isSuccess) Get.offAll(() => const CheckoutScreen());
//                 },
//               ),
//             ],
//           ),
//     );
//   }

//   void _showConfirmationDialog() {
//     showDialog(
//       context: context,
//       builder:
//           (_) => AlertDialog(
//             title: const Text("Confirm Payment"),
//             content: const Text(
//               "Once you proceed, the payment will be processed.",
//             ),
//             actions: [
//               TextButton(
//                 onPressed: () => Navigator.of(context).pop(),
//                 child: const Text("Cancel"),
//               ),
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                   _handleVisaPayment();
//                 },
//                 child: const Text(
//                   "Yes, Proceed",
//                   style: TextStyle(color: Colors.green),
//                 ),
//               ),
//             ],
//           ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final cardNumber = _cardNumberController.text;
//     final expiry = _expiryController.text;
//     final cvv = _cvvController.text;
//     final name = _nameController.text;

//     return Stack(
//       children: [
//         Scaffold(
//           appBar: AppBar(
//             title: const Text("Card Payment"),
//             backgroundColor: Colors.transparent,
//             elevation: 0,
//             iconTheme: IconThemeData(
//               color:
//                   Theme.of(context).brightness == Brightness.dark
//                       ? Colors.white
//                       : Colors.black,
//             ),
//           ),
//           body: SingleChildScrollView(
//             padding: const EdgeInsets.all(20),
//             child: Column(
//               children: [
//                 _buildCardPreview(cardNumber, expiry, cvv, name),
//                 const SizedBox(height: 30),
//                 Form(
//                   key: _formKey,
//                   child: Column(
//                     children: [
//                       _buildTextField(
//                         controller: _cardNumberController,
//                         label: 'Card Number',
//                         hint: '#### #### #### ####',
//                         icon: Icons.credit_card,
//                         keyboardType: TextInputType.number,
//                       ),
//                       const SizedBox(height: 16),
//                       Row(
//                         children: [
//                           Expanded(
//                             child: _buildTextField(
//                               controller: _expiryController,
//                               label: 'Expiry',
//                               hint: 'MM/YY',
//                               icon: Icons.calendar_today,
//                               keyboardType: TextInputType.datetime,
//                             ),
//                           ),
//                           const SizedBox(width: 16),
//                           Expanded(
//                             child: _buildTextField(
//                               controller: _cvvController,
//                               label: 'CVV',
//                               hint: '***',
//                               icon: Icons.lock,
//                               keyboardType: TextInputType.number,
//                               obscureText: true,
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 16),
//                       _buildTextField(
//                         controller: _nameController,
//                         label: 'Cardholder Name',
//                         hint: 'John Doe',
//                         icon: Icons.person,
//                       ),
//                       const SizedBox(height: 30),
//                       SizedBox(
//                         width: double.infinity,
//                         child: ElevatedButton(
//                           onPressed:
//                               _isProcessing ? null : _showConfirmationDialog,
//                           child:
//                               _isProcessing
//                                   ? const SizedBox(
//                                     width: 20,
//                                     height: 20,
//                                     child: CircularProgressIndicator(
//                                       color: Colors.white,
//                                       strokeWidth: 2,
//                                     ),
//                                   )
//                                   : const Text("Pay Now"),
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.green.shade600,
//                             foregroundColor: Colors.white,
//                             padding: const EdgeInsets.symmetric(vertical: 16),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         if (_isProcessing)
//           BackdropFilter(
//             filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
//             child: Container(
//               color: Colors.black.withOpacity(0.5),
//               alignment: Alignment.center,
//               child: const CircularProgressIndicator(color: Colors.white),
//             ),
//           ),
//       ],
//     );
//   }

//   Widget _buildCardPreview(
//     String cardNumber,
//     String expiry,
//     String cvv,
//     String name,
//   ) {
//     return Container(
//       width: double.infinity,
//       height: 200,
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(20),
//         gradient: const LinearGradient(
//           colors: [Colors.indigo, Colors.deepPurple],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//         boxShadow: const [
//           BoxShadow(
//             color: Colors.black12,
//             blurRadius: 10,
//             offset: Offset(0, 5),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             _cardType.isEmpty ? 'CARD' : _cardType,
//             style: const TextStyle(
//               color: Colors.white,
//               fontSize: 22,
//               fontWeight: FontWeight.bold,
//               letterSpacing: 2,
//             ),
//           ),
//           const Spacer(),
//           Text(
//             cardNumber.isEmpty
//                 ? '#### #### #### ####'
//                 : formatCardNumber(cardNumber),
//             style: const TextStyle(
//               color: Colors.white,
//               fontSize: 20,
//               letterSpacing: 2,
//             ),
//           ),
//           const SizedBox(height: 10),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 expiry.isEmpty ? 'MM/YY' : expiry,
//                 style: const TextStyle(color: Colors.white, fontSize: 16),
//               ),
//               Text(
//                 cvv.isEmpty ? 'CVV' : '***',
//                 style: const TextStyle(color: Colors.white, fontSize: 16),
//               ),
//             ],
//           ),
//           const SizedBox(height: 10),
//           Text(
//             name.isEmpty ? 'Cardholder Name' : name,
//             style: const TextStyle(color: Colors.white, fontSize: 16),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildTextField({
//     required TextEditingController controller,
//     required String label,
//     required String hint,
//     required IconData icon,
//     TextInputType keyboardType = TextInputType.text,
//     bool obscureText = false,
//   }) {
//     return TextFormField(
//       controller: controller,
//       keyboardType: keyboardType,
//       obscureText: obscureText,
//       validator: (value) {
//         if (value == null || value.isEmpty) {
//           return 'Please enter $label';
//         }
//         return null;
//       },
//       decoration: InputDecoration(
//         prefixIcon: Icon(icon),
//         labelText: label,
//         hintText: hint,
//         border: const OutlineInputBorder(
//           borderRadius: BorderRadius.all(Radius.circular(12)),
//         ),
//       ),
//     );
//   }
// }

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:baakas_seller/features/shop/controllers/product/cart_controller.dart';
import 'package:baakas_seller/features/shop/screens/checkout/checkout.dart';

class VisaCardDetailsScreen extends StatefulWidget {
  const VisaCardDetailsScreen({super.key});

  @override
  State<VisaCardDetailsScreen> createState() => _VisaCardDetailsScreenState();
}

class _VisaCardDetailsScreenState extends State<VisaCardDetailsScreen> {
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
    _cardNumberController.addListener(_detectCardType);
    _expiryController.addListener(() => setState(() {}));
    _cvvController.addListener(() => setState(() {}));
    _nameController.addListener(() => setState(() {}));
    Get.put(CartController());
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

  Future<void> _handleVisaPayment() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isProcessing = true);
    await Future.delayed(const Duration(seconds: 2));

    bool isValid =
        _cardNumberController.text.replaceAll(' ', '') == '4111111111111111' &&
        _cvvController.text == '123' &&
        _expiryController.text == '12/25';

    setState(() => _isProcessing = false);

    if (isValid) {
      try {
        final user = FirebaseAuth.instance.currentUser;
        final userId = user?.uid ?? 'anonymous';
        final cartController = Get.find<CartController>();
        final double checkoutAmount = cartController.totalCartPrice.value;

        await FirebaseFirestore.instance.collection('visa_payments').add({
          'card_number': _cardNumberController.text,
          'expiry_date': _expiryController.text,
          'cvv': _cvvController.text,
          'cardholder_name': _nameController.text,
          'card_type': _cardType,
          'timestamp': FieldValue.serverTimestamp(),
          'userId': userId,
          'amount': checkoutAmount,
        });
      } catch (e) {
        debugPrint('Error saving to Firestore: $e');
      }
    }

    _showPopup(
      title: isValid ? "Transaction Successful" : "Transaction Failed",
      message:
          isValid
              ? "Your payment has been processed successfully."
              : "Invalid card details. Please try again.",
      isSuccess: isValid,
    );
  }

  void _showPopup({
    required String title,
    required String message,
    required bool isSuccess,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
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
                  if (isSuccess) Get.offAll(() => const CheckoutScreen());
                },
              ),
            ],
          ),
    );
  }

  void _showConfirmationDialog() {
    FocusScope.of(context).unfocus(); // ✅ Hide keyboard before showing dialog

    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: const Text("Confirm Payment"),
            content: const Text(
              "Once you proceed, the payment will be processed.",
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text("Cancel"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();

                  // ✅ Hide keyboard again after dialog closes
                  FocusScope.of(context).unfocus();

                  _handleVisaPayment();
                },
                child: const Text(
                  "Yes, Proceed",
                  style: TextStyle(color: Colors.green),
                ),
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
            title: const Text("Card Payment"),
            backgroundColor: Colors.transparent,
            elevation: 0,
            iconTheme: IconThemeData(
              color:
                  Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black,
            ),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                _buildCardPreview(cardNumber, expiry, cvv, name),
                const SizedBox(height: 30),
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
                              icon: Icons.calendar_today,
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
                      const SizedBox(height: 30),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed:
                              _isProcessing
                                  ? null
                                  : () {
                                    if (_formKey.currentState!.validate()) {
                                      _showConfirmationDialog(); // Only show the dialog if form is valid
                                    }
                                  },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green.shade600,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child:
                              _isProcessing
                                  ? const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  )
                                  : const Text("Pay Now"),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        if (_isProcessing)
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
            child: Container(
              color: Colors.black.withOpacity(0.5),
              alignment: Alignment.center,
              child: const CircularProgressIndicator(color: Colors.white),
            ),
          ),
      ],
    );
  }

  Widget _buildCardPreview(
    String cardNumber,
    String expiry,
    String cvv,
    String name,
  ) {
    return Container(
      width: double.infinity,
      height: 200,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [Colors.indigo, Colors.deepPurple],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _cardType.isEmpty ? 'CARD' : _cardType,
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
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                expiry.isEmpty ? 'MM/YY' : expiry,
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
              Text(
                cvv.isEmpty ? 'CVV' : '***',
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            name.isEmpty ? 'Cardholder Name' : name,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Enter $label';
        }
        return null;
      },
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        labelText: label,
        hintText: hint,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),
    );
  }
}
