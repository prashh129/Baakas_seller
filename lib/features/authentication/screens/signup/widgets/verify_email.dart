import 'package:baakas_seller/common/widgets/success_screen/success_screen.dart';
import 'package:baakas_seller/features/authentication/screens/login/login.dart';
import 'package:baakas_seller/utils/constants/sizes.dart';
import 'package:baakas_seller/utils/constants/text_strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () => Get.offAll(() => const LoginScreen()),
            icon: const Icon(CupertinoIcons.clear),
          ),
        ],
      ),
      body: SingleChildScrollView(
        // Pading t give default equal space on all side in all screens.
        child: Padding(
          padding: const EdgeInsets.all(BaakasSizes.defaultSpace),
          child: Column(
            children: [
              /// Image
              const SizedBox(height: BaakasSizes.spaceBtwSections),

              /// Title & SubTitle
              Text(
                BaakasTexts.confirmEmail,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: BaakasSizes.spaceBtwItems),
              Text(
                'example@gmail.com',
                style: Theme.of(context).textTheme.labelLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: BaakasSizes.spaceBtwItems),
              Text(
                BaakasTexts.confirmEmailSubTitle,
                style: Theme.of(context).textTheme.labelMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: BaakasSizes.spaceBtwItems),

              /// Buttons
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed:
                      () => Get.to(
                        () => SuccessScreen(
                          image: '',
                          title: BaakasTexts.yourAccountCreatedTitle,
                          subTitle: BaakasTexts.changeYourPasswordSubTitle,
                          onPressed: () => Get.to(() => const LoginScreen()),
                        ),
                      ),
                  child: const Text(BaakasTexts.BaakasContinue),
                ),
              ),
              const SizedBox(height: BaakasSizes.spaceBtwItems),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {},
                  child: const Text(BaakasTexts.resendEmail),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
