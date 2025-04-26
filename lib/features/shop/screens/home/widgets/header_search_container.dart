// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:iconsax/iconsax.dart';
// import '../../../../../utils/constants/colors.dart';
// import '../../../../../utils/constants/sizes.dart';
// import '../../../../../utils/device/device_utility.dart';
// import '../../../../../utils/helpers/helper_functions.dart';
// import '../../search/search.dart';

// class BaakasSearchContainer extends StatelessWidget {
//   const BaakasSearchContainer({
//     super.key,
//     required this.text,
//     this.icon = Iconsax.search_normal,
//     this.showBackground = true,
//     this.showBorder = true,
//     this.onTap,
//     this.padding =
//         const EdgeInsets.symmetric(horizontal: BaakasSizes.defaultSpace),
//   });

//   final String text;
//   final IconData? icon;
//   final VoidCallback? onTap;
//   final bool showBackground, showBorder;
//   final EdgeInsetsGeometry padding;

//   @override
//   Widget build(BuildContext context) {
//     final dark = BaakasHelperFunctions.isDarkMode(context);
//     return GestureDetector(
//       onTap: () => Get.to(() => SearchScreen()),
//       child: Padding(
//         padding: padding,
//         child: Container(
//           width: BaakasDeviceUtils.getScreenWidth(context),
//           padding: const EdgeInsets.all(BaakasSizes.md),
//           decoration: BoxDecoration(
//             color: showBackground
//                 ? dark
//                     ? BaakasColors.dark
//                     : BaakasColors.light
//                 : Colors.transparent,
//             borderRadius: BorderRadius.circular(BaakasSizes.cardRadiusLg),
//             border: showBorder ? Border.all(color: BaakasColors.grey) : null,
//           ),
//           child: Row(
//             children: [
//               Icon(icon, color: dark ? BaakasColors.darkerGrey : Colors.grey),
//               const SizedBox(width: BaakasSizes.spaceBtwItems),
//               Text(text, style: Theme.of(context).textTheme.bodySmall),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
