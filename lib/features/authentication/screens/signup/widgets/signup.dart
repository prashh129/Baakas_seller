import 'package:baakas_seller/common/widgets/login_signup/form_divider.dart';
// import 'package:baakas/common/widgets/login_signup/social_buttons.dart';
import 'package:baakas_seller/features/authentication/screens/signup/signup_form.dart';
import 'package:baakas_seller/utils/constants/sizes.dart';
import 'package:baakas_seller/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(BaakasSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Title
              Text(
                BaakasTexts.signupTitle,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: BaakasSizes.spaceBtwSections),

              /// Form
              const BaakasSignupForm(),
              const SizedBox(height: BaakasSizes.spaceBtwSections),

              /// Divider
              const BaakasFormDivider(dividerText: ''),
              const SizedBox(height: BaakasSizes.spaceBtwSections),

              /// Social Button
              // const BaakasSocialButtons(), dipesh commented this
            ],
          ),
        ),
      ),
    );
  }
}
