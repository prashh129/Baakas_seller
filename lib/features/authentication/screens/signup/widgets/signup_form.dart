import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../../utils/validators/validation.dart';
import '../../../controllers/signup_controller.dart';
import 'terms_conditions_checkbox.dart';

class BaakasSignupForm extends StatelessWidget {
  const BaakasSignupForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());
    return Form(
      key: controller.signupFormKey,
      child: Column(
        children: [
          const SizedBox(height: BaakasSizes.spaceBtwSections),

          /// First & Last Name
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: controller.firstName,
                  validator:
                      (value) => BaakasValidator.validateEmptyText(
                        'First name',
                        value,
                      ),
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
                  controller: controller.lastName,
                  validator:
                      (value) =>
                          BaakasValidator.validateEmptyText('Last name', value),
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
            controller: controller.username,
            validator: BaakasValidator.validateUsername,
            expands: false,
            decoration: const InputDecoration(
              labelText: BaakasTexts.username,
              prefixIcon: Icon(Iconsax.user_edit),
            ),
          ),
          const SizedBox(height: BaakasSizes.spaceBtwInputFields),

          /// Email
          TextFormField(
            controller: controller.email,
            validator: BaakasValidator.validateEmail,
            decoration: const InputDecoration(
              labelText: BaakasTexts.email,
              prefixIcon: Icon(Iconsax.direct),
            ),
          ),
          const SizedBox(height: BaakasSizes.spaceBtwInputFields),

          /// Phone Number
          TextFormField(
            controller: controller.phoneNumber,
            validator: BaakasValidator.validatePhoneNumber,
            decoration: const InputDecoration(
              labelText: BaakasTexts.mobileNo,
              prefixIcon: Icon(Iconsax.call),
            ),
          ),
          const SizedBox(height: BaakasSizes.spaceBtwInputFields),

          /// Gender Dropdown
          Obx(
            () => DropdownButtonFormField<String>(
              value:
                  controller.selectedGender.value.isNotEmpty
                      ? controller.selectedGender.value
                      : null,
              items:
                  ['Male', 'Female', 'Other']
                      .map(
                        (gender) => DropdownMenuItem(
                          value: gender,
                          child: Text(gender),
                        ),
                      )
                      .toList(),
              onChanged:
                  (value) => controller.selectedGender.value = value ?? '',
              validator:
                  (value) =>
                      value == null || value.isEmpty
                          ? 'Please select your gender'
                          : null,
              decoration: const InputDecoration(
                labelText: 'Gender',
                prefixIcon: Icon(Iconsax.user),
              ),
            ),
          ),
          const SizedBox(height: BaakasSizes.spaceBtwInputFields),

          /// Date of Birth (No Obx needed)
          TextFormField(
            controller: controller.dateOfBirthController,
            validator:
                (value) =>
                    value == null || value.isEmpty
                        ? 'Please select your date of birth'
                        : null,
            onTap: () async {
              FocusScope.of(context).requestFocus(FocusNode());
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
              );
              if (pickedDate != null) {
                controller.dateOfBirthController.text =
                    '${pickedDate.day}/${pickedDate.month}/${pickedDate.year}';
              }
            },
            readOnly: true,
            decoration: const InputDecoration(
              labelText: 'Date of Birth',
              prefixIcon: Icon(Iconsax.calendar),
            ),
          ),
          const SizedBox(height: BaakasSizes.spaceBtwInputFields),

          /// Password
          Obx(
            () => TextFormField(
              controller: controller.password,
              validator: BaakasValidator.validatePassword,
              obscureText: controller.hidePassword.value,
              decoration: InputDecoration(
                labelText: BaakasTexts.password,
                prefixIcon: const Icon(Iconsax.password_check),
                suffixIcon: IconButton(
                  onPressed:
                      () =>
                          controller.hidePassword.value =
                              !controller.hidePassword.value,
                  icon: const Icon(Iconsax.eye_slash),
                ),
              ),
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
              onPressed: () => controller.signup(),
              child: const Text(BaakasTexts.createAccount),
            ),
          ),
        ],
      ),
    );
  }
}
