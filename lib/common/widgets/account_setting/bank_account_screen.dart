import 'package:flutter/material.dart';
import 'package:baakas_seller/utils/constants/image_strings.dart';
import '../../../common/widgets/appbar/appbar.dart';

class BankAccountScreen extends StatelessWidget {
  const BankAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BaakasAppBar(
        showBackArrow: true,
        title: Text("Bank Account"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              BaakasImages.bankPayment,
              height: 300,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 24),
            const Center(
              child: Text(
                "Banking payment is currently unavailable",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
