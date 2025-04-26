// import 'package:baakas/features/authentication/screens/signup/terms_conditions_checbox.dart';
// import 'package:baakas/features/authentication/screens/signup/verify_email.dart';
// import 'package:baakas/utils/constants/sizes.dart';
// import 'package:baakas/utils/constants/text_strings.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:iconsax/iconsax.dart';

// class BaakasSignupForm extends StatelessWidget {
//   const BaakasSignupForm({super.key});

//   get controller => null;

//   @override
//   Widget build(BuildContext context) {
//     //final controller = Get.put(SignupController());
//     return Form(
//       //key: controller.signupFormKey,
//       child: Column(
//         children: [
//           Row(
//             children: [
//               Expanded(
//                 child: TextFormField(
//                   //controller: controller.firstName,
//                   //validator: (value) => BaakasValidator.validateEmptyText('First name',value),
//                   expands: false,
//                   decoration: const InputDecoration(
//                     labelText: BaakasTexts.firstName,
//                     prefixIcon: Icon(Iconsax.user),
//                   ),
//                 ),
//               ),
//               const SizedBox(width: BaakasSizes.spaceBtwInputFields),
//               Expanded(
//                 child: TextFormField(
//                   //validator: (value) => BaakasValidator.validateEmptyText('Last name',value),
//                   //controller: controller.lastName,
//                   expands: false,
//                   decoration: const InputDecoration(
//                     labelText: BaakasTexts.lastName,
//                     prefixIcon: Icon(Iconsax.user),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: BaakasSizes.spaceBtwInputFields),

//           /// Username
//           TextFormField(
//             //validator: (value) => BaakasValidator.validateEmptyText('User name',value),
//             //controller: controller.username,
//             expands: false,
//             decoration: const InputDecoration(
//               labelText: BaakasTexts.username,
//               prefixIcon: Icon(Iconsax.user_edit),
//             ),
//           ),
//           const SizedBox(height: BaakasSizes.spaceBtwInputFields),

//           /// Email
//           TextFormField(
//             //validator: (value) => BaakasValidator.validateEmail(value),
//             //controller: controller.email,
//             expands: false,
//             decoration: const InputDecoration(
//               labelText: BaakasTexts.email,
//               prefixIcon: Icon(Iconsax.direct),
//             ),
//           ),
//           const SizedBox(height: BaakasSizes.spaceBtwInputFields),

//           /// Mobile Number
//           TextFormField(
//             //validator: (value) => BaakasValidator.validatePhoneNumber(value),
//             //controller: controller.mobileNumber,
//             expands: false,
//             decoration: const InputDecoration(
//               labelText: BaakasTexts.mobileNo,
//               prefixIcon: Icon(Iconsax.call),
//             ),
//           ),
//           const SizedBox(height: BaakasSizes.spaceBtwInputFields),

//           /// Password
//           TextFormField(
//             //validator: (value) => BaakasValidator.validatePassword(value),
//             //controller: controller.password,
//             expands: false,
//             decoration: const InputDecoration(
//               labelText: BaakasTexts.password,
//               prefixIcon: Icon(Iconsax.password_check),
//               suffixIcon: Icon(Iconsax.eye_slash),
//             ),
//           ),
//           const SizedBox(height: BaakasSizes.spaceBtwSections),

//           /// Terms&Conditions Checkbox
//           const BaakasTermsAndConditionCheckbox(),
//           const SizedBox(height: BaakasSizes.spaceBtwSections),

//           /// Sign Up Button
//           SizedBox(
//             width: double.infinity,
//             child: ElevatedButton(
//               onPressed: () => Get.to(() => const VerifyEmailScreen()),
//               child: const Text(BaakasTexts.createAccount),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:baakas_seller/features/authentication/screens/signup/terms_conditions_checbox.dart';
import 'package:baakas_seller/features/authentication/screens/signup/verify_email.dart';
import 'package:baakas_seller/utils/constants/sizes.dart';
import 'package:baakas_seller/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class BaakasSignupForm extends StatefulWidget {
  const BaakasSignupForm({super.key});

  @override
  State<BaakasSignupForm> createState() => _BaakasSignupFormState();
}

class _BaakasSignupFormState extends State<BaakasSignupForm> {
  String _selectedRole = 'buyer';

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  expands: false,
                  decoration: const InputDecoration(
                    labelText: BaakasTexts.firstName,
                    prefixIcon: Icon(Iconsax.user),
                  ),
                ),
              ),
              const SizedBox(width: BaakasSizes.spaceBtwInputFields),
              Expanded(
                child: TextFormField(
                  expands: false,
                  decoration: const InputDecoration(
                    labelText: BaakasTexts.lastName,
                    prefixIcon: Icon(Iconsax.user),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: BaakasSizes.spaceBtwInputFields),

          /// Username
          TextFormField(
            expands: false,
            decoration: const InputDecoration(
              labelText: BaakasTexts.username,
              prefixIcon: Icon(Iconsax.user_edit),
            ),
          ),
          const SizedBox(height: BaakasSizes.spaceBtwInputFields),

          /// Email
          TextFormField(
            expands: false,
            decoration: const InputDecoration(
              labelText: BaakasTexts.email,
              prefixIcon: Icon(Iconsax.direct),
            ),
          ),
          const SizedBox(height: BaakasSizes.spaceBtwInputFields),

          /// Mobile Number
          TextFormField(
            expands: false,
            decoration: const InputDecoration(
              labelText: BaakasTexts.mobileNo,
              prefixIcon: Icon(Iconsax.call),
            ),
          ),
          const SizedBox(height: BaakasSizes.spaceBtwInputFields),

          /// Password
          TextFormField(
            expands: false,
            decoration: const InputDecoration(
              labelText: BaakasTexts.password,
              prefixIcon: Icon(Iconsax.password_check),
              suffixIcon: Icon(Iconsax.eye_slash),
            ),
          ),
          const SizedBox(height: BaakasSizes.spaceBtwInputFields),

          /// User Role Dropdown
          DropdownButtonFormField<String>(
            value: _selectedRole,
            items:
                ['buyer', 'seller'].map((role) {
                  return DropdownMenuItem(
                    value: role,
                    child: Text(role.capitalize!),
                  );
                }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedRole = value!;
              });
            },
            decoration: const InputDecoration(
              labelText: 'Select your role',
              prefixIcon: Icon(Iconsax.user_tag),
            ),
          ),

          const SizedBox(height: BaakasSizes.spaceBtwSections),

          /// Terms&Conditions Checkbox
          const BaakasTermsAndConditionCheckbox(),
          const SizedBox(height: BaakasSizes.spaceBtwSections),

          /// Sign Up Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Get.to(() => const VerifyEmailScreen()),
              child: const Text(BaakasTexts.createAccount),
            ),
          ),
        ],
      ),
    );
  }
}
