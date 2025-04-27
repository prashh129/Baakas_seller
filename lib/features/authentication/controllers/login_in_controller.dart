import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';

import '../../../data/repositories/authentication/authentication_repository.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/helpers/network_manager.dart';
import '../../../utils/popups/full_screen_loader.dart';
import '../../../utils/popups/loaders.dart';
import '../../personalization/controllers/user_controller.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  /// Variables
  final hidePassword = true.obs;
  final rememberMe = false.obs;
  final localStorage = GetStorage();
  final email = TextEditingController();
  final password = TextEditingController();
  final userController = Get.put(UserController());
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final isLoading = false.obs;
  final _logger = Logger();
  final _networkManager = NetworkManager.instance;
  final _storage = GetStorage();
  final _authRepository = AuthenticationRepository.instance;

  @override
  void onInit() {
    email.text = localStorage.read('REMEMBER_ME_EMAIL') ?? '';
    password.text = localStorage.read('REMEMBER_ME_PASSWORD') ?? '';
    super.onInit();
  }

  /// -- Email and Password SignIn
  Future<void> emailPasswordSignIn() async {
    try {
      isLoading.value = true;
      _logger.i('Starting email/password sign in process');
      
      // Check internet connectivity
      if (!await _networkManager.isConnected()) {
        _logger.w('No internet connection available');
        throw 'Please check your internet connection';
      }

      // Validate form
      if (!loginFormKey.currentState!.validate()) {
        _logger.w('Form validation failed');
        isLoading.value = false;
        return;
      }

      // Save credentials if remember me is checked
      if (rememberMe.value) {
        _logger.i('Saving credentials for remember me');
        await _storage.write('email', email.text.trim());
        await _storage.write('password', password.text.trim());
      }

      _logger.i('Attempting to sign in with email: ${email.text.trim()}');
      final userCredential = await _authRepository.loginWithEmailAndPassword(
        email.text.trim(),
        password.text.trim(),
      );

      _logger.i('Successfully signed in user: ${userCredential.user?.uid}');
      
      // Clear form
      email.text = '';
      password.text = '';
      
      // Navigate to home
      await AuthenticationRepository.instance.screenRedirect(userCredential.user);
    } catch (e) {
      _logger.e('Error during email/password sign in: $e');
      BaakasLoaders.errorSnackBar(
        title: 'Oh Snap!',
        message: e.toString(),
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// Google SignIn Authentication
  Future<void> googleSignIn() async {
    try {
      // Start Loading
      BaakasFullScreenLoader.openLoadingDialog(
        'Logging you in...',
        BaakasImages.docerAnimation,
      );

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        BaakasFullScreenLoader.stopLoading();
        return;
      }

      // Google Authentication
      final userCredentials =
          await AuthenticationRepository.instance.signInWithGoogle();

      // Save Authenticated user data in the Firebase Firestore
      await userController.saveUserRecord(userCredentials: userCredentials);

      // Remove Loader
      BaakasFullScreenLoader.stopLoading();

      // Redirect
      await AuthenticationRepository.instance.screenRedirect(
        userCredentials?.user,
      );
    } catch (e) {
      BaakasFullScreenLoader.stopLoading();
      BaakasLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }

  /// Facebook SignIn Authentication
  Future<void> facebookSignIn() async {
    try {
      // Start Loading
      BaakasFullScreenLoader.openLoadingDialog(
        'Logging you in...',
        BaakasImages.docerAnimation,
      );

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        BaakasFullScreenLoader.stopLoading();
        return;
      }

      // Facebook Authentication
      final userCredentials =
          await AuthenticationRepository.instance.signInWithFacebook();

      // Save Authenticated user data in the Firebase Firestore
      await userController.saveUserRecord(userCredentials: userCredentials);

      // Remove Loader
      BaakasFullScreenLoader.stopLoading();

      // Redirect
      await AuthenticationRepository.instance.screenRedirect(
        userCredentials.user,
      );
    } catch (e) {
      BaakasFullScreenLoader.stopLoading();
      BaakasLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }
}
