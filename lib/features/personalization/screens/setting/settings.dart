import 'package:baakas_seller/common/widgets/account_setting/accountPrivacyScreen.dart';
import 'package:baakas_seller/common/widgets/account_setting/bankAcccountScreen.dart';
import 'package:baakas_seller/common/widgets/account_setting/notification_screen_setting.dart';
import 'package:baakas_seller/features/personalization/screens/document/DocumentsUploadScreen.dart';
import 'package:baakas_seller/features/settings_language/screens/language_screen.dart';
import 'package:baakas_seller/features/settings/controllers/language_controller.dart';
import '../../../../common/widgets/list_tiles/user_profile_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/custom_shapes/containers/primary_header_container.dart';
import '../../../../common/widgets/list_tiles/settings_menu_tile.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../home_menu.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../controllers/user_controller.dart';
import '../address/address.dart';
import '../profile/profile.dart';
import 'upload_data.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    final languageController = LanguageController.instance;
    return PopScope(
      canPop: false,
      // Intercept the back button press and redirect to Home Screen
      onPopInvoked: (value) async => Get.offAll(const HomeMenu()),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              /// -- Header
              BaakasPrimaryHeaderContainer(
                child: Column(
                  children: [
                    /// AppBar
                    BaakasAppBar(
                      title: Text(
                        languageController.translate('Account'),
                        style: Theme.of(context).textTheme.headlineMedium!
                            .apply(color: BaakasColors.white),
                      ),
                    ),

                    /// User Profile Card
                    BaakasUserProfileTile(
                      onPressed: () => Get.to(() => const ProfileScreen()),
                    ),
                    const SizedBox(height: BaakasSizes.spaceBtwSections),
                  ],
                ),
              ),

              /// -- Profile Body
              Padding(
                padding: const EdgeInsets.all(BaakasSizes.defaultSpace),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// -- Account  Settings
                    BaakasSectionHeading(
                      title: languageController.translate('Account Settings'),
                      showActionButton: false,
                    ),
                    const SizedBox(height: BaakasSizes.spaceBtwItems),

                    // / Dipesh Added this thing
                    BaakasSettingsMenuTile(
                      icon: Iconsax.document,
                      title: languageController.translate('Document'),
                      subTitle: languageController.translate(
                        'Insert or edit your document',
                      ),
                      onTap: () => Get.to(() => const DocumentsUploadScreen()),
                    ),

                    /// Language setting
                    BaakasSettingsMenuTile(
                      icon: Iconsax.language_circle,
                      title: languageController.translate('Language'),
                      subTitle: languageController.translate(
                        'Please select your language',
                      ),
                      onTap: () => Get.to(() => const LanguageScreen()),
                    ),
                    BaakasSettingsMenuTile(
                      icon: Iconsax.safe_home,
                      title: languageController.translate('My Addresses'),
                      subTitle: languageController.translate(
                        'Set shopping delivery address',
                      ),
                      onTap: () => Get.to(() => const UserAddressScreen()),
                    ),
                    // BaakasSettingsMenuTile(
                    //   icon: Iconsax.shopping_cart,
                    //   title: 'My Cart',
                    //   subTitle: 'Add, remove products and move to checkout',
                    //   onTap: () => Get.to(() => const CartScreen()),
                    // ),
                    BaakasSettingsMenuTile(
                      icon: Iconsax.bank,
                      title: languageController.translate('Bank Account'),
                      subTitle: languageController.translate(
                        'Withdraw balance to registered bank account',
                      ),
                      onTap: () {
                        // Navigate to the BankAccountScreen when tapped
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const BankAccountScreen(),
                          ),
                        );
                      },
                    ),
                    // const BaakasSettingsMenuTile(
                    //   icon: Iconsax.discount_shape,
                    //   title: 'My Coupons',
                    //   subTitle: 'List of all the discounted coupons',
                    // ),
                    BaakasSettingsMenuTile(
                      icon: Iconsax.notification,
                      title: languageController.translate('Notifications'),
                      subTitle: languageController.translate(
                        'Set any kind of notification message',
                      ),
                      onTap: () {
                        // Navigate to the NotificationScreen when tapped
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => const NotificationScreenSetting(),
                          ),
                        );
                      },
                    ),
                    BaakasSettingsMenuTile(
                      icon: Iconsax.security_card,
                      title: languageController.translate('Account Privacy'),
                      subTitle: languageController.translate(
                        'Manage data usage and connected accounts',
                      ),
                      onTap: () {
                        // Navigate to the AccountPrivacyScreen when tapped
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AccountPrivacyScreen(),
                          ),
                        );
                      },
                    ),

                    /// -- App Settings
                    const SizedBox(height: BaakasSizes.spaceBtwSections),
                    BaakasSectionHeading(
                      title: languageController.translate('App Settings'),
                      showActionButton: false,
                    ),
                    const SizedBox(height: BaakasSizes.spaceBtwItems),
                    BaakasSettingsMenuTile(
                      icon: Iconsax.document_upload,
                      title: languageController.translate('Load Data'),
                      subTitle: languageController.translate(
                        'Upload Data to your Cloud Firebase',
                      ),
                      onTap: () => Get.to(() => const UploadDataScreen()),
                    ),
                    const SizedBox(height: BaakasSizes.spaceBtwItems),
                    BaakasSettingsMenuTile(
                      icon: Iconsax.location,
                      title: languageController.translate('Geolocation'),
                      subTitle: languageController.translate(
                        'Set recommendation based on location',
                      ),
                      trailing: Switch(
                        value: true,
                        onChanged: (value) {},
                        activeColor: Colors.green,
                        inactiveThumbColor: Colors.grey,
                      ),
                    ),
                    BaakasSettingsMenuTile(
                      icon: Iconsax.security_user,
                      title: languageController.translate('Safe Mode'),
                      subTitle: languageController.translate(
                        'Search result is safe for all ages',
                      ),
                      trailing: Switch(
                        value: true,
                        onChanged: (value) {},
                        activeColor: Colors.green,
                        inactiveThumbColor: Colors.grey,
                      ),
                    ),
                    BaakasSettingsMenuTile(
                      icon: Iconsax.image,
                      title: languageController.translate('HD Image Quality'),
                      subTitle: languageController.translate(
                        'Set image quality to be seen',
                      ),
                      trailing: Switch(
                        value: false,
                        onChanged: (value) {},
                        activeColor: Colors.green,
                        inactiveThumbColor: Colors.grey,
                      ),
                    ),

                    /// -- Logout Button
                    const SizedBox(height: BaakasSizes.spaceBtwSections),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () => controller.logout(),
                        child: Text(languageController.translate('Logout')),
                      ),
                    ),
                    const SizedBox(height: BaakasSizes.spaceBtwSections * 2.5),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
