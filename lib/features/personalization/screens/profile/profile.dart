import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/images/Baakas_circular_image.dart';
import '../../../../common/widgets/shimmers/shimmer.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../controllers/user_controller.dart';
import 'change_name.dart';
import 'widgets/profile_menu.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Scaffold(
      appBar: BaakasAppBar(
        showBackArrow: true,
        title: Text(
          'Profile',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(BaakasSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    Obx(() {
                      final networkImage = controller.user.value.profilePicture;
                      final image =
                          networkImage.isNotEmpty
                              ? networkImage
                              : BaakasImages.user;
                      return controller.imageUploading.value
                          ? const BaakasShimmerEffect(
                            width: 80,
                            height: 80,
                            radius: 80,
                          )
                          : BaakasCircularImage(
                            image: image,
                            width: 80,
                            height: 80,
                            isNetworkImage: networkImage.isNotEmpty,
                          );
                    }),
                    TextButton(
                      onPressed:
                          controller.imageUploading.value
                              ? () {}
                              : () => controller.uploadUserProfilePicture(),
                      child: const Text('Change Profile Picture'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: BaakasSizes.spaceBtwItems / 2),
              const Divider(),
              const SizedBox(height: BaakasSizes.spaceBtwItems),
              const BaakasSectionHeading(
                title: 'Profile Information',
                showActionButton: false,
              ),
              const SizedBox(height: BaakasSizes.spaceBtwItems),
              BaakasProfileMenu(
                onPressed: () => Get.to(() => const ChangeName()),
                title: 'Name',
                value: controller.user.value.fullName,
              ),
              BaakasProfileMenu(
                onPressed: () {},
                title: 'Username',
                value: controller.user.value.username,
              ),
              const SizedBox(height: BaakasSizes.spaceBtwItems),
              const Divider(),
              const SizedBox(height: BaakasSizes.spaceBtwItems),
              const BaakasSectionHeading(
                title: 'Personal Information',
                showActionButton: false,
              ),
              const SizedBox(height: BaakasSizes.spaceBtwItems),
              BaakasProfileMenu(
                onPressed: () {},
                title: 'User ID',
                value: '45689',
                icon: Iconsax.copy,
              ),
              BaakasProfileMenu(
                onPressed: () {},
                title: 'E-mail',
                value: controller.user.value.email,
              ),
              BaakasProfileMenu(
                onPressed: () {},
                title: 'Phone Number',
                value: controller.user.value.phoneNumber,
              ),
              BaakasProfileMenu(
                onPressed: () {},
                title: 'Gender',
                value:
                    controller.user.value.gender.isNotEmpty == true
                        ? controller.user.value.gender
                        : 'Not specified', // Fallback value for gender
              ),

              BaakasProfileMenu(
                onPressed: () {},
                title: 'Date of Birth',
                value:
                    controller.user.value.dateOfBirth?.isNotEmpty == true
                        ? controller.user.value.dateOfBirth!
                        : 'Not specified', // Fallback value for date of birth
              ),

              const Divider(),
              const SizedBox(height: BaakasSizes.spaceBtwItems),
              Center(
                child: TextButton(
                  onPressed: () => controller.deleteAccountWarningPopup(),
                  child: const Text(
                    'Close Account',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
