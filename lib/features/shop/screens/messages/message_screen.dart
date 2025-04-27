import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../controllers/message_controller.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = BaakasHelperFunctions.isDarkMode(context);
    Get.put(MessageController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Messages'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: dark ? BaakasColors.black : Colors.white,
      body: const Center(
        child: Text(
          'No conversations yet',
          style: TextStyle(color: Colors.grey, fontSize: 16),
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: 2,
        destinations: const [
          NavigationDestination(icon: Icon(Iconsax.home), label: 'Home'),
          NavigationDestination(icon: Icon(Iconsax.shop), label: 'Product'),
          NavigationDestination(icon: Icon(Iconsax.message), label: 'Message'),
          NavigationDestination(
            icon: Icon(Iconsax.profile_circle),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
