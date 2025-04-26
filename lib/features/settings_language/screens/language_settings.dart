import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:get_storage/get_storage.dart';
import '../../../common/widgets/appbar/appbar.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/constants/colors.dart';

class LanguageSettings extends StatelessWidget {
  const LanguageSettings({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final currentLocale = Get.locale?.languageCode ?? 'en';

    return Scaffold(
      appBar: const BaakasAppBar(
        showBackArrow: true,
        title: Text('Language Settings'),
      ),
      body: Container(
        color: isDark ? BaakasColors.black : BaakasColors.white,
        child: Padding(
          padding: const EdgeInsets.all(BaakasSizes.defaultSpace),
          child: Column(
            children: [
              // Language Selection Card
              Card(
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
                      color: Theme.of(context).primaryColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Iconsax.language_square,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  title: Text(
                    'Select Language',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    'Choose your preferred language',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).textTheme.bodySmall?.color,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: BaakasSizes.spaceBtwSections),

              // Language Options
              _buildLanguageOption(
                context,
                'English',
                'en',
                'English',
                Iconsax.global,
                Theme.of(context).primaryColor,
                currentLocale == 'en',
              ),
              const SizedBox(height: BaakasSizes.spaceBtwItems),
              _buildLanguageOption(
                context,
                'नेपाली',
                'ne',
                'Nepali',
                Iconsax.global,
                Theme.of(context).primaryColor,
                currentLocale == 'ne',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLanguageOption(
    BuildContext context,
    String languageName,
    String languageCode,
    String languageSubtitle,
    IconData icon,
    Color color,
    bool isSelected,
  ) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Card(
      elevation: 2,
      color: isDark ? BaakasColors.darkerGrey : Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color),
        ),
        title: Text(
          languageName,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          languageSubtitle,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).textTheme.bodySmall?.color,
          ),
        ),
        trailing: isSelected
            ? Icon(Iconsax.tick_circle, color: Theme.of(context).primaryColor)
            : const SizedBox.shrink(),
        onTap: () {
          GetStorage().write('language', languageCode);
          Get.updateLocale(Locale(languageCode));
        },
      ),
    );
  }
}
