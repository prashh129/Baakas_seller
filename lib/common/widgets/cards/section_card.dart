import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';

class BaakasSectionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;
  final Color? iconBackgroundColor;
  final Color? iconColor;
  final double? iconSize;

  const BaakasSectionCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
    this.iconBackgroundColor,
    this.iconColor,
    this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(BaakasSizes.defaultSpace),
        decoration: BoxDecoration(
          color: BaakasColors.primaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(BaakasSizes.cardRadiusLg),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(BaakasSizes.sm),
              decoration: BoxDecoration(
                color: iconBackgroundColor ?? BaakasColors.primaryColor,
                borderRadius: BorderRadius.circular(BaakasSizes.sm),
              ),
              child: Icon(
                icon,
                color: iconColor ?? Colors.white,
                size: iconSize ?? 24,
              ),
            ),
            const SizedBox(width: BaakasSizes.spaceBtwItems),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: BaakasSizes.spaceBtwItems / 2),
                  Text(subtitle, style: Theme.of(context).textTheme.bodySmall),
                ],
              ),
            ),
            const Icon(Iconsax.arrow_right_3, size: BaakasSizes.iconSm),
          ],
        ),
      ),
    );
  }
}
