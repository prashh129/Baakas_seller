import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../controllers/promotions_controller.dart';

class CouponCreation extends StatelessWidget {
  const CouponCreation({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PromotionsController());

    return Obx(() {
      if (controller.coupons.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Iconsax.discount_shape,
                size: 64,
                color: Theme.of(
                  context,
                ).textTheme.bodyLarge?.color?.withValues(alpha: 128),
              ),
              const SizedBox(height: 16),
              Text(
                'No Coupons Created Yet',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.color?.withValues(alpha: 128),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Create your first coupon code to start offering discounts',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.color?.withValues(alpha: 128),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      }

      return ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: controller.coupons.length,
        itemBuilder: (context, index) {
          final coupon = controller.coupons[index];
          return StatefulBuilder(
            builder: (context, setState) {
              bool isHovered = false;
              return MouseRegion(
                onEnter: (_) => setState(() => isHovered = true),
                onExit: (_) => setState(() => isHovered = false),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color:
                          isHovered
                              // ignore: dead_code
                              ? Theme.of(context).primaryColor.withValues(alpha: 51)
                              : Colors.transparent,
                      width: 2,
                    ),
                    boxShadow:
                        isHovered
                            // ignore: dead_code
                            ? [
                              BoxShadow(
                                color: Theme.of(
                                  context,
                                ).primaryColor.withValues(alpha: 89),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ]
                            : null,
                  ),
                  child: InkWell(
                    onTap: () {
                      // Handle coupon tap
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Theme.of(
                                context,
                              ).primaryColor.withValues(alpha: 51),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              Iconsax.discount_shape,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  coupon.code,
                                  style: Theme.of(context).textTheme.titleMedium
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '${coupon.discount}% off',
                                  style: Theme.of(
                                    context,
                                  ).textTheme.bodyMedium?.copyWith(
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.color
                                        ?.withValues(alpha: 179),
                                  ),
                                ),
                                Text(
                                  'Expires: ${coupon.expiryDate.toString().split(' ')[0]}',
                                  style: Theme.of(
                                    context,
                                  ).textTheme.bodySmall?.copyWith(
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.color
                                        ?.withValues(alpha: 128),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '${coupon.usedCount}/${coupon.usageLimit}',
                                style: Theme.of(context).textTheme.titleMedium
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Used',
                                style: Theme.of(
                                  context,
                                ).textTheme.bodySmall?.copyWith(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.color
                                      ?.withValues(alpha: 128),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      );
    });
  }
}
