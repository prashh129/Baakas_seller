import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../utils/constants/colors.dart';
import '../utils/helpers/helper_functions.dart';
import 'navigation_controller.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    final darkMode = BaakasHelperFunctions.isDarkMode(context);

    return Scaffold(
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
      bottomNavigationBar: Obx(
        () => Container(
          decoration: BoxDecoration(
            color: darkMode ? BaakasColors.black : Colors.white,
            boxShadow: [
              BoxShadow(
                color: darkMode
                    ? BaakasColors.white.withOpacity(0.05)
                    : BaakasColors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: NavigationBar(
                height: 65,
                backgroundColor: Colors.transparent,
                elevation: 0,
                indicatorColor: darkMode
                    ? BaakasColors.white.withOpacity(0.1)
                    : BaakasColors.primaryColor.withOpacity(0.1),
                labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
                selectedIndex: controller.selectedIndex.value,
                onDestinationSelected: controller.changeIndex,
                destinations: [
                  NavigationDestination(
                    icon: Icon(
                      Iconsax.home,
                      color: darkMode ? BaakasColors.grey : BaakasColors.darkGrey,
                    ),
                    selectedIcon: Icon(
                      Iconsax.home,
                      color: darkMode ? BaakasColors.white : BaakasColors.primaryColor,
                    ),
                    label: 'Home',
                  ),
                  NavigationDestination(
                    icon: Icon(
                      Iconsax.box,
                      color: darkMode ? BaakasColors.grey : BaakasColors.darkGrey,
                    ),
                    selectedIcon: Icon(
                      Iconsax.box,
                      color: darkMode ? BaakasColors.white : BaakasColors.primaryColor,
                    ),
                    label: 'Products',
                  ),
                  NavigationDestination(
                    icon: Icon(
                      Iconsax.shopping_cart,
                      color: darkMode ? BaakasColors.grey : BaakasColors.darkGrey,
                    ),
                    selectedIcon: Icon(
                      Iconsax.shopping_cart,
                      color: darkMode ? BaakasColors.white : BaakasColors.primaryColor,
                    ),
                    label: 'Orders',
                  ),
                  NavigationDestination(
                    icon: Icon(
                      Iconsax.setting,
                      color: darkMode ? BaakasColors.grey : BaakasColors.darkGrey,
                    ),
                    selectedIcon: Icon(
                      Iconsax.setting,
                      color: darkMode ? BaakasColors.white : BaakasColors.primaryColor,
                    ),
                    label: 'Settings',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: Obx(() {
        if (controller.selectedIndex.value == 1) {
          return const SizedBox.shrink();
        }
        return const SizedBox.shrink();
      }),
    );
  }
} 