import 'package:baakas_seller/utils/constants/enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/repositories/authentication/authentication_repository.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/helpers/network_manager.dart';
import '../../personalization/controllers/user_controller.dart';
import '../../personalization/models/user_model.dart';
import '../screens/signup/verify_email.dart';
import '../../../utils/popups/full_screen_loader.dart';
import '../../../utils/popups/loaders.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  /// Variables
  final hidePassword = true.obs; // Observable for hiding/showing password
  final privacyPolicy = true.obs; // Observable for privacy policy acceptance
  final email = TextEditingController(); // Controller for email input
  final lastName = TextEditingController(); // Controller for last name input
  final username = TextEditingController(); // Controller for username input
  final password = TextEditingController(); // Controller for password input
  final firstName = TextEditingController(); // Controller for first name input
  final phoneNumber =
      TextEditingController(); // Controller for phone number input
  final RxString selectedGender = ''.obs; // Gender dropdown selection
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();
  final TextEditingController dateOfBirthController = TextEditingController();
  late final AppRole role;

  // Form key for form validation

  /// -- SIGNUP
  Future<void> signup() async {
    try {
      // Start Loading
      BaakasFullScreenLoader.openLoadingDialog(
        'We are processing your information...',
        BaakasImages.docerAnimation,
      );

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        BaakasFullScreenLoader.stopLoading();
        return;
      }

      // Form Validation
      if (!signupFormKey.currentState!.validate()) {
        BaakasFullScreenLoader.stopLoading();
        return;
      }

      // Privacy Policy Check
      if (!privacyPolicy.value) {
        BaakasFullScreenLoader.stopLoading();
        BaakasLoaders.warningSnackBar(
          title: 'Accept Privacy Policy',
          message:
              'In order to create account, you must have to read and accept the Privacy Policy & Terms of Use.',
        );
        return;
      }

      // Register user in the Firebase Authentication & Save user data in the Firebase
      await AuthenticationRepository.instance.registerWithEmailAndPassword(
        email.text.trim(),
        password.text.trim(),
      );

      // Save Authenticated user data in the Firebase Firestore
      final newUser = UserModel(
        id: AuthenticationRepository.instance.getUserID,
        firstName: firstName.text.trim(),
        lastName: lastName.text.trim(),
        username: username.text.trim(),
        email: email.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        profilePicture: '',
        address: '',
        role: AppRole.seller,
        isEmailVerified: false,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        bio: null,
        website: null,
        socialLinks: {},
        preferences: {},
      );

      await UserController.instance.saveUserRecord(user: newUser);

      // Remove Loader
      BaakasFullScreenLoader.stopLoading();

      // Show Success Message
      BaakasLoaders.successSnackBar(
        title: 'Congratulations',
        message: 'Your account has been created! Verify email to continue.',
      );

      // Move to Verify Email Screen
      Get.to(() => const VerifyEmailScreen());
    } catch (e) {
      // Show some Generic Error to the user
      BaakasFullScreenLoader.stopLoading();
      BaakasLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}
