import 'package:baakas_seller/features/shop/screens/Dashboard/features/ManageProductsScreen%20.dart';
import 'package:baakas_seller/features/shop/screens/products_seller/widgets/productControllerSeller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:baakas_seller/features/communication/screens/customer_communication_screen.dart';
import 'package:baakas_seller/features/personalization/screens/setting/settings.dart';
import 'package:baakas_seller/features/shop/screens/products_seller/product_model.dart';
import 'package:baakas_seller/features/shop/screens/products_seller/widgets/add_product_screen.dart';
import 'package:baakas_seller/features/shop/screens/home/home.dart';
import 'package:baakas_seller/utils/constants/colors.dart';
import 'package:baakas_seller/utils/helpers/helper_functions.dart';
import 'features/orders/screens/order_management_screen.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    // Main tab controller
    final navCtrl = Get.put(NavigationController());

    // Global product controller
    final productCtrl = Get.put(ProductControllerSeller());

    final darkMode = BaakasHelperFunctions.isDarkMode(context);

    return Scaffold(
      extendBody: true, // allow FAB to float over the NavigationBar

      body: Obx(() => navCtrl.screens[navCtrl.selectedIndex.value]),

      bottomNavigationBar: Obx(
        () => NavigationBar(
          selectedIndex: navCtrl.selectedIndex.value,
          onDestinationSelected: (idx) => navCtrl.selectedIndex.value = idx,
          backgroundColor: darkMode ? BaakasColors.black : Colors.white,
          indicatorColor:
              darkMode
                  ? BaakasColors.white.withOpacity(0.1)
                  : BaakasColors.black.withOpacity(0.1),
          destinations: const [
            NavigationDestination(icon: Icon(Iconsax.home), label: 'Home'),
            NavigationDestination(
              icon: Icon(Iconsax.shop),
              label: 'Manage Products',
            ),
            NavigationDestination(icon: Icon(Iconsax.box), label: 'Orders'),
            NavigationDestination(
              icon: Icon(Iconsax.message),
              label: 'Message',
            ),
            NavigationDestination(icon: Icon(Iconsax.user), label: 'Profile'),
          ],
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Obx(() {
        // only on the "Manage Products" tab (index 1)
        if (navCtrl.selectedIndex.value == 1) {
          return FloatingActionButton(
            onPressed: () async {
              final newProduct = await Navigator.push<ProductModelSeller?>(
                context,
                MaterialPageRoute(builder: (_) => const AddProductScreen()),
              );
              if (newProduct != null) {
                productCtrl.addProduct(newProduct);
              }
            },
            backgroundColor: BaakasColors.primaryColor,
            child: const Icon(Icons.add),
          );
        }
        return const SizedBox.shrink();
      }),
    );
  }
}

class NavigationController extends GetxController {
  final RxInt selectedIndex = 0.obs;

  final screens = [
    const HomeScreen(),
    const ManageProductsScreen(),
    OrderManagementScreen(),
    const CustomerCommunicationScreen(),
    const SettingsScreen(),
  ];
}
