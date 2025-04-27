import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/repositories/user/user_repository.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/helpers/network_manager.dart';
import '../../../utils/popups/full_screen_loader.dart';
import '../../../utils/popups/loaders.dart';
import '../screens/profile/profile.dart';
import '../models/user_model.dart';
import 'user_controller.dart';

/// Controller to manage user-related functionality.
class UpdateNameController extends GetxController {
  static UpdateNameController get instance => Get.find();

  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final userController = UserController.instance;
  final userRepository = Get.put(UserRepository());
  final networkManager = Get.put(NetworkManager());
  GlobalKey<FormState> updateUserNameFormKey = GlobalKey<FormState>();

  /// init user data when Home Screen appears
  @override
  void onInit() {
    initializeNames();
    super.onInit();
  }

  /// Fetch user record
  Future<void> initializeNames() async {
    firstName.text = userController.user.value.firstName;
    lastName.text = userController.user.value.lastName;
  }

  Future<void> updateUserName() async {
    try {
      // Start Loading
      BaakasFullScreenLoader.openLoadingDialog(
          'We are updating your information...', BaakasImages.docerAnimation);

      // Check Internet Connectivity
      final isConnected = await networkManager.isConnected();
      if (!isConnected) {
        BaakasFullScreenLoader.stopLoading();
        return;
      }

      // Form Validation
      if (!updateUserNameFormKey.currentState!.validate()) {
        BaakasFullScreenLoader.stopLoading();
        return;
      }

      // Update user's first & last name in the Firebase Firestore
      Map<String, dynamic> name = {
        'firstName': firstName.text.trim(),
        'lastName': lastName.text.trim(),
        'updatedAt': DateTime.now(),
      };
      await userRepository.updateSingleField(name);

      // Update the Rx User value
      final updatedUser = UserModel(
        id: userController.user.value.id,
        email: userController.user.value.email,
        firstName: firstName.text.trim(),
        lastName: lastName.text.trim(),
        username: userController.user.value.username,
        phoneNumber: userController.user.value.phoneNumber,
        profilePicture: userController.user.value.profilePicture,
        address: userController.user.value.address,
        role: userController.user.value.role,
        isEmailVerified: userController.user.value.isEmailVerified,
        createdAt: userController.user.value.createdAt,
        updatedAt: DateTime.now(),
        bio: userController.user.value.bio,
        website: userController.user.value.website,
        socialLinks: userController.user.value.socialLinks,
        preferences: userController.user.value.preferences,
      );
      userController.user.value = updatedUser;
      userController.user.refresh();

      // Remove Loader
      BaakasFullScreenLoader.stopLoading();

      // Show Success Message
      BaakasLoaders.successSnackBar(
          title: 'Congratulations', message: 'Your Name has been updated.');

      // Move to previous screen.
      Get.off(() => const ProfileScreen());
    } catch (e) {
      BaakasFullScreenLoader.stopLoading();
      BaakasLoaders.errorSnackBar(
        title: 'Oh Snap!',
        message: e.toString(),
      );
    }
  }
}
