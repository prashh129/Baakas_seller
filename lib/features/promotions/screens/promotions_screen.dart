import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../common/widgets/appbar/appbar.dart';
import '../widgets/coupon_creation.dart';
import '../widgets/seasonal_offers.dart';
import '../widgets/discount_analytics.dart';
import '../controllers/promotions_controller.dart';

class PromotionsScreen extends StatelessWidget {
  const PromotionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PromotionsController());
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(120),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const BaakasAppBar(
                  showBackArrow: true,
                  title: Text('Promotions & Discounts'),
                ),
                Material(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: TabBar(
                    labelColor: Theme.of(context).textTheme.bodyLarge?.color,
                    unselectedLabelColor: Theme.of(
                      context,
                    ).textTheme.bodyLarge?.color?.withOpacity(0.5),
                    indicatorColor: Theme.of(context).primaryColor,
                    tabs: const [
                      Tab(icon: Icon(Iconsax.discount_shape), text: 'Coupons'),
                      Tab(
                        icon: Icon(Iconsax.calendar),
                        text: 'Seasonal Offers',
                      ),
                      Tab(icon: Icon(Iconsax.chart), text: 'Analytics'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [const CouponCreation(), const SeasonalOffers(), DiscountAnalytics()],
        ),
        floatingActionButton: Obx(() {
          if (controller.selectedTab.value == 0) {
            return FloatingActionButton(
              onPressed: () => controller.createNewCoupon(),
              backgroundColor: Theme.of(context).primaryColor,
              child: Icon(
                Iconsax.add,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            );
          } else if (controller.selectedTab.value == 1) {
            return FloatingActionButton(
              onPressed: () => controller.createNewSeasonalOffer(),
              backgroundColor: Theme.of(context).primaryColor,
              child: Icon(
                Iconsax.add,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            );
          }
          return const SizedBox.shrink();
        }),
      ),
    );
  }
}
