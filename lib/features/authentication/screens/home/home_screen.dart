import 'package:flutter/material.dart';
import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/custom_shapes/containers/primary_header_container.dart';
import '../../../../common/widgets/search_container.dart';
import '../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../common/widgets/products/product_cards/product_card_vertical.dart';
import '../../../../common/widgets/section_heading.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/helpers/helper_functions.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header
            BaakasPrimaryHeaderContainer(
              child: Column(
                children: [
                  // AppBar
                  BaakasAppBar(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          BaakasTexts.homeAppbarTitle,
                          style: Theme.of(context).textTheme.headlineMedium?.apply(
                                color: BaakasColors.white,
                                fontWeightDelta: 2,
                              ),
                        ),
                        const SizedBox(height: BaakasSizes.spaceBtwItems),
                        Text(
                          BaakasTexts.homeAppbarSubTitle,
                          style: Theme.of(context).textTheme.bodyMedium?.apply(
                                color: BaakasColors.white.withOpacity(0.8),
                              ),
                        ),
                      ],
                    ),
                    actions: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.shopping_cart_outlined,
                          color: BaakasColors.white,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.notifications_outlined,
                          color: BaakasColors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: BaakasSizes.spaceBtwSections),
                  // Search Bar
                  const BaakasSearchContainer(
                    hintText: BaakasTexts.search,
                    icon: Icons.search,
                    showBorder: false,
                    showBackground: false,
                    padding: EdgeInsets.zero,
                  ),
                  const SizedBox(height: BaakasSizes.spaceBtwSections),
                ],
              ),
            ),
            // Body
            Padding(
              padding: const EdgeInsets.all(BaakasSizes.defaultSpace),
              child: Column(
                children: [
                  // Promo Banner
                  const BaakasPromoBanner(),
                  const SizedBox(height: BaakasSizes.spaceBtwSections),
                  // Heading
                  BaakasSectionHeading(
                    title: BaakasTexts.popularProducts,
                    onPressed: () {},
                  ),
                  const SizedBox(height: BaakasSizes.spaceBtwItems),
                  // Popular Products
                  BaakasGridLayout(
                    itemCount: 4,
                    itemBuilder: (_, index) => const BaakasProductCardVertical(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BaakasPromoBanner extends StatelessWidget {
  const BaakasPromoBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(BaakasSizes.md),
      decoration: BoxDecoration(
        color: BaakasColors.secondaryColor,
        borderRadius: BorderRadius.circular(BaakasSizes.cardRadiusLg),
      ),
      child: Row(
        children: [
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  BaakasTexts.promoBannerTitle,
                  style: Theme.of(context).textTheme.titleLarge?.apply(
                        color: BaakasColors.white,
                        fontWeightDelta: 2,
                      ),
                ),
                const SizedBox(height: BaakasSizes.sm),
                Text(
                  BaakasTexts.promoBannerSubTitle,
                  style: Theme.of(context).textTheme.bodyMedium?.apply(
                        color: BaakasColors.white.withOpacity(0.8),
                      ),
                ),
              ],
            ),
          ),
          const SizedBox(width: BaakasSizes.spaceBtwItems),
          Image.asset(
            BaakasImages.promoBanner1,
            height: 100,
            fit: BoxFit.contain,
          ),
        ],
      ),
    );
  }
} 