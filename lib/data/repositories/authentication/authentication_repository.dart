import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../features/authentication/screens/login/login.dart';
import '../../../features/authentication/screens/signup/verify_email.dart';
import '../../../navigation/navigation_menu.dart';
import '../../../utils/exceptions/firebase_auth_exceptions.dart';
import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/format_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';
import '../../../utils/local_storage/storage_utility.dart';
import '../user/user_repository.dart';
import 'package:logger/logger.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();
  final _logger = Logger();

  /// Variables
  final GetStorage deviceStorage;
  late final Rx<User?> _firebaseUser;
  final _auth = FirebaseAuth.instance;

  /// Constructor
  AuthenticationRepository() : deviceStorage = GetStorage() {
    _firebaseUser = Rx<User?>(_auth.currentUser);
  }

  /// Getters
  User? get firebaseUser => _firebaseUser.value;

  String get getUserID => _firebaseUser.value?.uid ?? "";

  String get getUserEmail => _firebaseUser.value?.email ?? "";

  String get getDisplayName => _firebaseUser.value?.displayName ?? "";

  String get getPhoneNo => _firebaseUser.value?.phoneNumber ?? "";

  /// Called from main.dart on app launch
  @override
  void onReady() {
    _firebaseUser.bindStream(_auth.userChanges());
    FlutterNativeSplash.remove();

    // Use a delayed navigation to ensure GetMaterialApp is ready
    Future.delayed(const Duration(milliseconds: 100), () {
      screenRedirect(_firebaseUser.value);
    });
  }

  /// Function to Show Relevant Screen
  screenRedirect(User? user) async {
    if (user != null) {
      // User Logged-In: If email verified let the user go to Home Screen else to the Email Verification Screen
      if (user.emailVerified) {
        // Initialize User Specific Storage
        try {
          await BaakasLocalStorage.init(user.uid);
          Get.offAll(() => const NavigationMenu());
        } catch (e) {
          debugPrint("Error initializing storage: $e");
          // Fallback to default storage
          await BaakasLocalStorage.init('baakas_default');
          Get.offAll(() => const NavigationMenu());
        }
      } else {
        Get.offAll(() => VerifyEmailScreen(email: getUserEmail));
      }
    } else {
      Get.offAll(
        () => const LoginScreen(),
      );
    }
  }

  /* ---------------------------- Email & Password sign-in ---------------------------------*/

  /// [EmailAuthentication] - SignIn
  Future<UserCredential> loginWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      _logger.i('Attempting to login user with email: $email');
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      _logger.i('Successfully logged in user: ${userCredential.user?.uid}');
      return userCredential;
    } on FirebaseAuthException catch (e) {
      _logger.e('Firebase Auth Error during login: ${e.code} - ${e.message}');
      throw BaakasFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      _logger.e('Firebase Error during login: ${e.code} - ${e.message}');
      throw BaakasFirebaseException(e.code).message;
    } on FormatException catch (e) {
      _logger.e('Format Error during login: $e');
      throw const BaakasFormatException();
    } on PlatformException catch (e) {
      _logger.e('Platform Error during login: ${e.code} - ${e.message}');
      throw BaakasPlatformException(e.code).message;
    } catch (e) {
      _logger.e('Unexpected error during login: $e');
      throw 'Something went wrong. Please try again';
    }
  }

  /// [EmailAuthentication] - REGISTER
  Future<UserCredential> registerWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw BaakasFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw BaakasFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const BaakasFormatException();
    } on PlatformException catch (e) {
      throw BaakasPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// [ReAuthenticate] - ReAuthenticate User
  Future<void> reAuthenticateWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      // Create a credential
      AuthCredential credential = EmailAuthProvider.credential(
        email: email,
        password: password,
      );

      // ReAuthenticate
      await _auth.currentUser!.reauthenticateWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      throw BaakasFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw BaakasFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const BaakasFormatException();
    } on PlatformException catch (e) {
      throw BaakasPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// [EmailVerification] - MAIL VERIFICATION
  Future<void> sendEmailVerification() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      throw BaakasFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw BaakasFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const BaakasFormatException();
    } on PlatformException catch (e) {
      throw BaakasPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// [EmailAuthentication] - FORGET PASSWORD
  Future<void> sendPasswordResetEmail(email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw BaakasFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw BaakasFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const BaakasFormatException();
    } on PlatformException catch (e) {
      throw BaakasPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /* ---------------------------- Federated identity & social sign-in ---------------------------------*/

  /// [GoogleAuthentication] - GOOGLE
  Future<UserCredential?> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      throw BaakasFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw BaakasFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const BaakasFormatException();
    } on PlatformException catch (e) {
      throw BaakasPlatformException(e.code).message;
    } catch (e) {
      if (kDebugMode) print('Something went wrong: $e');
      return null;
    }
  }

  ///[FacebookAuthentication] - FACEBOOK
  Future<UserCredential> signInWithFacebook() async {
    try {
      // Trigger the sign-in flow
      final LoginResult loginResult = await FacebookAuth.instance.login(
        permissions: ['email'],
      );

      // Create a credential from the access token
      final AccessToken accessToken = loginResult.accessToken!;
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(accessToken.tokenString);

      // Once signed in, return the UserCredential
      return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
    } on FirebaseAuthException catch (e) {
      throw BaakasFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw BaakasFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const BaakasFormatException();
    } on PlatformException catch (e) {
      throw BaakasPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /* ---------------------------- ./end Federated identity & social sign-in ---------------------------------*/

  /// [LogoutUser] - Valid for any authentication.
  Future<void> logout() async {
    try {
      // Try to sign out from Google
      try {
        _logger.i("Attempting Google Sign Out...");
        await GoogleSignIn().signOut();
        _logger.i("Google Sign Out Successful.");
      } catch (e) {
        _logger.e("Google Sign Out Error: $e");
      }

      // Try to log out from Facebook
      try {
        _logger.i("Attempting Facebook Log Out...");
        await FacebookAuth.instance.logOut();
        _logger.i("Facebook Log Out Successful.");
      } catch (e) {
        _logger.e("Facebook Log Out Error: $e");
      }

      // Firebase sign out
      _logger.i("Attempting Firebase Sign Out...");
      await FirebaseAuth.instance.signOut();
      _logger.i("Firebase Sign Out Successful.");

      // Navigate to login screen
      _logger.i("Navigating to Login Screen...");
      Get.offAll(() => const LoginScreen());
    } on FirebaseAuthException catch (e) {
      _logger.e("FirebaseAuthException: ${e.code}");
      throw BaakasFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      _logger.e("FirebaseException: ${e.code}");
      throw BaakasFirebaseException(e.code).message;
    } on FormatException catch (_) {
      _logger.e("FormatException occurred.");
      throw const BaakasFormatException();
    } on PlatformException catch (e) {
      _logger.e("PlatformException: ${e.code}");
      throw BaakasPlatformException(e.code).message;
    } catch (e, stackTrace) {
      _logger.e('Unexpected Logout Error: $e', error: e, stackTrace: stackTrace);
      throw 'Something went wrong. Please try again';
    }
  }

  /// DELETE USER - Remove user Auth and Firestore Account.
  Future<void> deleteAccount() async {
    try {
      await UserRepository.instance.removeUserRecord(_auth.currentUser!.uid);
      await _auth.currentUser?.delete();
    } on FirebaseAuthException catch (e) {
      throw BaakasFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw BaakasFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const BaakasFormatException();
    } on PlatformException catch (e) {
      throw BaakasPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
}
