import 'package:baakas_seller/features/shop/screens/Dashboard/features/ManageProductsScreen%20.dart';
import 'package:baakas_seller/features/shop/screens/home/home.dart';
import 'package:baakas_seller/utils/constants/colors.dart';
import 'package:baakas_seller/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'features/personalization/screens/setting/settings.dart';
import 'features/orders/screens/order_management_screen.dart';

class HomeMenu extends StatelessWidget {
  const HomeMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AppScreenController());
    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          height: 80,
          animationDuration: const Duration(seconds: 3),
          selectedIndex: controller.selectedMenu.value,
          backgroundColor:
              BaakasHelperFunctions.isDarkMode(context)
                  ? BaakasColors.black
                  : Colors.white,
          elevation: 0,
          indicatorColor:
              BaakasHelperFunctions.isDarkMode(context)
                  ? BaakasColors.white.withOpacity(0.1)
                  : BaakasColors.black.withOpacity(0.1),
          onDestinationSelected:
              (index) => controller.selectedMenu.value = index,
          destinations: const [
            NavigationDestination(icon: Icon(Iconsax.home), label: 'Home'),
            NavigationDestination(icon: Icon(Iconsax.shop), label: 'Product'),
            NavigationDestination(icon: Icon(Iconsax.box), label: 'Orders'),
            NavigationDestination(icon: Icon(Iconsax.user), label: 'Profile'),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: Obx(() => controller.screens[controller.selectedMenu.value]),
    );
  }
}

class AppScreenController extends GetxController {
  static AppScreenController get instance => Get.find();

  final Rx<int> selectedMenu = 0.obs;

  final screens = [
    const HomeScreen(),
    const ManageProductsScreen(),
    OrderManagementScreen(),
    const SettingsScreen(),
  ];
}
