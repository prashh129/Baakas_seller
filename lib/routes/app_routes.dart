import 'package:baakas_seller/features/authentication/screens/login/login.dart';
import 'package:baakas_seller/features/authentication/screens/password_configuration/forget_password.dart';
import 'package:baakas_seller/features/shop/screens/Dashboard/features/ManageProductsScreen.dart';
import 'package:baakas_seller/features/shop/screens/home/home.dart';
import 'package:baakas_seller/features/orders/screens/order_management_screen.dart';
import 'package:baakas_seller/features/shop/screens/messages/conversations_screen.dart';
import '../features/authentication/screens/signup/signup.dart';
import '../features/authentication/screens/signup/verify_email.dart';
import '../features/personalization/screens/address/address.dart';
import '../features/personalization/screens/profile/profile.dart';
import '../features/personalization/screens/setting/settings.dart';
import 'routes.dart';
import 'package:get/get.dart';

class AppRoutes {
  static final pages = [
    // GetPage(name: BaakasRoutes.home, page: () => const HomeScreen()),
    /// I added this shitt!
    // GetPage(name: BaakasRoutes.home, page: () => const HomeScreen()),
    // // GetPage(name: BaakasRoutes.store, page: () => const StoreScreen()),
    // GetPage(name: BaakasRoutes.favourites, page: () => const FavouriteScreen()),
    // GetPage(name: BaakasRoutes.settings, page: () => const SettingsScreen()),
    GetPage(name: BaakasRoutes.home, page: () => const HomeScreen()),
    GetPage(name: BaakasRoutes.store, page: () => const ManageProductsScreen()),
    GetPage(
      name: BaakasRoutes.favourites,
      page: () => const ConversationsScreen(currentUserId: ''),
    ),
    GetPage(name: BaakasRoutes.settings, page: () => const SettingsScreen()),
    GetPage(name: BaakasRoutes.order, page: () => const OrderManagementScreen()),
    // GetPage(name: BaakasRoutes.cart, page: () => const CartScreen()),
    GetPage(name: BaakasRoutes.userProfile, page: () => const ProfileScreen()),
    GetPage(
      name: BaakasRoutes.userAddress,
      page: () => const UserAddressScreen(),
    ),
    GetPage(name: BaakasRoutes.signup, page: () => const SignupScreen()),
    GetPage(
      name: BaakasRoutes.verifyEmail,
      page: () => const VerifyEmailScreen(),
    ),
    GetPage(name: BaakasRoutes.signIn, page: () => const LoginScreen()),
    GetPage(
      name: BaakasRoutes.forgetPassword,
      page: () => const ForgetPasswordScreen(),
    ),
  ];
}
