import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/styles/spacing_styles.dart';
import '../../../../common/widgets/login_signup/form_divider.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';
import 'widgets/login_form.dart';
import 'widgets/login_header.dart';
import '../../controllers/login_in_controller.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize LoginController
    Get.put(LoginController());

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: BaakasSpacingStyle.paddingWithAppBarHeight,
          child: Column(
            children: [
              ///  Header
              const BaakasLoginHeader(),

              /// Form
              const BaakasLoginForm(),

              /// Divider
              BaakasFormDivider(
                dividerText: BaakasTexts.orSignInWith.capitalize!,
              ),
              const SizedBox(height: BaakasSizes.spaceBtwSections),

              /// Footer
              // const BaakasSocialButtons(), dipesh commented this
            ],
          ),
        ),
      ),
    );
  }
}
