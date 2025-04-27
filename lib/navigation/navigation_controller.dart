import 'package:get/get.dart';
import 'package:baakas_seller/features/shop/screens/home/home.dart';
import 'package:baakas_seller/features/shop/screens/Dashboard/features/ManageProductsScreen.dart';
import 'package:baakas_seller/features/orders/screens/order_management_screen.dart';
import 'package:baakas_seller/features/personalization/screens/setting/settings.dart';

class NavigationController extends GetxController {
  static NavigationController get instance => Get.find();

  final RxInt selectedIndex = 0.obs;
  final RxInt productsTabIndex = 0.obs; // 0 for approved tab

  final screens = [
    const HomeScreen(),
    const ManageProductsScreen(),
    const OrderManagementScreen(),
    const SettingsScreen(),
  ];

  void changeIndex(int index) {
    if (selectedIndex.value != index) {
      selectedIndex.value = index;
      // Reset products tab to approved when navigating to products section
      if (index == 1) {
        productsTabIndex.value = 0;
      }
    }
  }
} 