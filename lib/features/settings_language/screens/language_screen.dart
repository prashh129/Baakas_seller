import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../features/settings/controllers/language_controller.dart';
import '../../../common/widgets/appbar/appbar.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/constants/colors.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize the LanguageController
    final controller = Get.put(LanguageController());
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: BaakasAppBar(
        showBackArrow: true,
        title: Text(controller.translate('Select Language')),
      ),
      body: Container(
        color: isDark ? BaakasColors.black : BaakasColors.white,
        child: Padding(
          padding: const EdgeInsets.all(BaakasSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Language Information
              const SizedBox(height: BaakasSizes.spaceBtwItems),
              Expanded(
                child: ListView.builder(
                  itemCount: controller.languages.length,
                  itemBuilder: (context, index) {
                    final language = controller.languages[index];
                    return Obx(() {
                      final isSelected =
                          controller.selectedLanguage.value == language;
                      return Card(
                        elevation: 2,
                        color: isDark ? BaakasColors.darkerGrey : Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          leading: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Theme.of(
                                context,
                              ).primaryColor.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              Iconsax.global,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          title: Text(
                            language,
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          trailing:
                              isSelected
                                  ? Icon(
                                    Iconsax.tick_circle,
                                    color: Theme.of(context).primaryColor,
                                  )
                                  : null,
                          onTap: () => controller.changeLanguage(language),
                        ),
                      );
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
