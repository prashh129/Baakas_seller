// import 'package:baakas_seller/features/authentication/screens/login/login.dart';
// import 'package:baakas_seller/features/authentication/screens/password_configuration/forget_password.dart';
// import 'package:baakas_seller/features/shop/screens/Dashboard/features/ManageProductsScreen%20.dart';
// import 'package:baakas_seller/features/shop/screens/home/home.dart';
// import 'package:baakas_seller/features/shop/screens/Dashboard/features/SellerOrdersScreen.dart';
// import 'package:baakas_seller/features/shop/screens/messages/conversations_screen.dart';
// import 'package:get/get_navigation/src/routes/get_route.dart';
// import '../features/authentication/screens/onboarding/onboarding.dart';
// import '../features/authentication/screens/signup/signup.dart';
// import '../features/authentication/screens/signup/verify_email.dart';
// import '../features/personalization/screens/address/address.dart';
// import '../features/personalization/screens/profile/profile.dart';
// import '../features/personalization/screens/setting/settings.dart';
// import '../features/shop/screens/checkout/checkout.dart';
// import '../features/shop/screens/product_reviews/product_reviews.dart';
// import '../features/shop/screens/search/search.dart';
// import 'routes.dart';

// class AppRoutes {
//   static final pages = [
//     // GetPage(name: BaakasRoutes.home, page: () => const HomeScreen()),
//     /// I added this shitt!
//     // GetPage(name: BaakasRoutes.home, page: () => const HomeScreen()),
//     // // GetPage(name: BaakasRoutes.store, page: () => const StoreScreen()),
//     // GetPage(name: BaakasRoutes.favourites, page: () => const FavouriteScreen()),
//     // GetPage(name: BaakasRoutes.settings, page: () => const SettingsScreen()),
//     GetPage(name: BaakasRoutes.home, page: () => const HomeScreen()),
//     GetPage(name: BaakasRoutes.store, page: () => const ManageProductsScreen()),
//     GetPage(
//       name: BaakasRoutes.favourites,
//       page: () => const ConversationsScreen(currentUserId: ''),
//     ),
//     GetPage(name: BaakasRoutes.settings, page: () => const SettingsScreen()),
//     GetPage(name: BaakasRoutes.search, page: () => SearchScreen()),
//     GetPage(
//       name: BaakasRoutes.productReviews,
//       page: () => const ProductReviewsScreen(),
//     ),
//     GetPage(name: BaakasRoutes.order, page: () => const SellerOrdersScreen()),
//     GetPage(name: BaakasRoutes.checkout, page: () => const CheckoutScreen()),
//     // GetPage(name: BaakasRoutes.cart, page: () => const CartScreen()),
//     GetPage(name: BaakasRoutes.userProfile, page: () => const ProfileScreen()),
//     GetPage(
//       name: BaakasRoutes.userAddress,
//       page: () => const UserAddressScreen(),
//     ),
//     GetPage(name: BaakasRoutes.signup, page: () => const SignupScreen()),
//     GetPage(
//       name: BaakasRoutes.verifyEmail,
//       page: () => const VerifyEmailScreen(),
//     ),
//     GetPage(name: BaakasRoutes.signIn, page: () => const LoginScreen()),
//     GetPage(
//       name: BaakasRoutes.forgetPassword,
//       page: () => const ForgetPasswordScreen(),
//     ),
//     GetPage(
//       name: BaakasRoutes.onBoarding,
//       page: () => const OnBoardingScreen(),
//     ),
//     // Add more GetPage entries as needed
//   ];
// }
import 'package:baakas_seller/features/authentication/screens/login/login.dart';
import 'package:baakas_seller/features/authentication/screens/password_configuration/forget_password.dart';
import 'package:baakas_seller/features/shop/screens/Dashboard/features/ManageProductsScreen%20.dart';
import 'package:baakas_seller/features/shop/screens/home/home.dart';
import 'package:baakas_seller/features/orders/screens/order_management_screen.dart';
import 'package:baakas_seller/features/shop/screens/messages/conversations_screen.dart';
import '../features/authentication/screens/signup/signup.dart';
import '../features/authentication/screens/signup/verify_email.dart';
import '../features/personalization/screens/address/address.dart';
import '../features/personalization/screens/profile/profile.dart';
import '../features/personalization/screens/setting/settings.dart';
import '../features/shop/screens/checkout/checkout.dart';
import '../features/shop/screens/product_reviews/product_reviews.dart';
import '../features/shop/screens/search/search.dart';
import 'routes.dart';
import 'package:get/get.dart';
import '../features/orders/screens/order_details_screen.dart';

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
    GetPage(name: BaakasRoutes.search, page: () => SearchScreen()),
    GetPage(
      name: BaakasRoutes.productReviews,
      page: () => const ProductReviewsScreen(),
    ),
    GetPage(name: BaakasRoutes.order, page: () => OrderManagementScreen()),
    GetPage(name: BaakasRoutes.checkout, page: () => const CheckoutScreen()),
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
    GetPage(
      name: '/order-details',
      page: () => OrderDetailsScreen(order: Get.arguments),
    ),
  ];
}
