import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'app.dart';
import 'data/repositories/authentication/authentication_repository.dart';
import 'firebase_options.dart';
import 'features/settings/controllers/language_controller.dart';
import 'features/shop/controllers/category_controller.dart';

/// -- Entry point of Flutter App
Future<void> main() async {
  try {
    // Initialize Flutter bindings
    final WidgetsBinding widgetsBinding =
        WidgetsFlutterBinding.ensureInitialized();
    debugPrint("WidgetsBinding initialized");

    // Preserve splash screen
    FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
    debugPrint("Splash preserved");

    // Initialize GetStorage first
    await GetStorage.init();
    debugPrint("GetStorage initialized");

    // Configure system UI
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom],
    );

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
    );

    // Initialize Firebase
    try {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      debugPrint("Firebase initialized successfully");
    } catch (e) {
      debugPrint("Firebase initialization failed: $e");
    }

    // Initialize AuthenticationRepository
    try {
      final authRepo = AuthenticationRepository();
      Get.put(authRepo);
      debugPrint("AuthenticationRepository initialized");
    } catch (e) {
      debugPrint("AuthRepository initialization failed: $e");
    }

    // Initialize LanguageController
    try {
      final languageController = LanguageController();
      Get.put(languageController);
      debugPrint("LanguageController initialized");
    } catch (e) {
      debugPrint("LanguageController initialization failed: $e");
    }

    // Initialize CategoryController
    try {
      final categoryController = CategoryController();
      Get.put(categoryController);
      debugPrint("CategoryController initialized");
    } catch (e) {
      debugPrint("CategoryController initialization failed: $e");
    }

    // Run the app
    runApp(const App());
    debugPrint("App launched");

    // Remove splash screen after a delay
    Future.delayed(const Duration(milliseconds: 100), () {
      FlutterNativeSplash.remove();
      debugPrint("Splash removed");
    });
  } catch (e, stack) {
    debugPrint("Fatal error during initialization: $e");
    debugPrintStack(stackTrace: stack);
    FlutterNativeSplash.remove();
    rethrow;
  }
}
