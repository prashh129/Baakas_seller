import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../controllers/messages_controller.dart';

class UserActionDialogs {
  static void showBlockUserDialog(String userId, String userName) {
    Get.dialog(
      AlertDialog(
        title: const Text('Block User'),
        content: Text(
          'Are you sure you want to block $userName? You won\'t receive messages from them anymore.',
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              final controller = Get.find<MessagesController>();
              controller.blockUser(userId);
              Get.back();
            },
            child: const Text(
              'Block',
              style: TextStyle(color: BaakasColors.error),
            ),
          ),
        ],
      ),
    );
  }

  static void showReportUserDialog(String userId, String userName) {
    final reasonController = TextEditingController();

    Get.dialog(
      AlertDialog(
        title: const Text('Report User'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Why are you reporting $userName?'),
            const SizedBox(height: BaakasSizes.sm),
            TextField(
              controller: reasonController,
              maxLines: 3,
              decoration: const InputDecoration(
                hintText: 'Please provide details...',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              if (reasonController.text.trim().isEmpty) {
                Get.snackbar(
                  'Error',
                  'Please provide a reason for reporting',
                  backgroundColor: BaakasColors.error.withOpacity(0.1),
                  colorText: BaakasColors.error,
                  icon: const Icon(
                    Iconsax.warning_2,
                    color: BaakasColors.error,
                  ),
                );
                return;
              }

              final controller = Get.find<MessagesController>();
              controller.reportUser(userId, reasonController.text.trim());
              Get.back();
            },
            child: const Text(
              'Report',
              style: TextStyle(color: BaakasColors.error),
            ),
          ),
        ],
      ),
    );
  }
}
