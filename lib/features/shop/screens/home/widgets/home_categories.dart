import 'package:baakas_seller/common/widgets/image_text_widgets/vertical_image_text.dart';
import 'package:baakas_seller/common/widgets/shimmers/category_shimmer.dart';
import 'package:baakas_seller/features/shop/controllers/categories_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BaakasHomeCategories extends StatelessWidget {
  const BaakasHomeCategories({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryController = Get.put(CategoryController());

    return Obx(() {
      if (categoryController.isLoading.value) {
        return const BaakasCategoryShimmer();
      }

      if (categoryController.featuredCategories.isEmpty) {
        return Center(
          child: Text(
            'No Data Found!',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium!.apply(color: Colors.white),
          ),
        );
      }

      return SizedBox(
        height: 80,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: 6,
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, index) {
            final category = categoryController.featuredCategories[index];
            return BaakasVerticalImageText(
              image: category.image ?? 'assets/images/categories/default_category.png',
              title: category.name,
              onTap: () {},
            );
          },
        ),
      );
    });
  }
}
