// import 'package:baakas_seller/features/shop/screens/Dashboard/features/CustomerMessagesScreen.dart';
// import 'package:baakas_seller/features/shop/screens/Dashboard/features/ManageProductsScreen%20.dart';
// import 'package:baakas_seller/features/shop/screens/Dashboard/features/SellerOrdersScreen.dart';
// import 'package:baakas_seller/features/shop/screens/Dashboard/features/WithdrawFundsScreen.dart';
// import 'package:baakas_seller/features/shop/screens/upload_image/UploadProductImageScreen.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:iconsax/iconsax.dart';
// import '../../../../utils/constants/colors.dart';
// import '../../../../utils/constants/sizes.dart';

// class SellerDashboardScreen extends StatelessWidget {
//   const SellerDashboardScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final isDark = Theme.of(context).brightness == Brightness.dark;

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Seller Dashboard'),
//         centerTitle: true,
//         automaticallyImplyLeading: false,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(BaakasSizes.defaultSpace),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Overview Section
//             Text('Overview', style: Theme.of(context).textTheme.titleLarge),
//             const SizedBox(height: BaakasSizes.spaceBtwItems),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 _StatCard(title: 'Orders', value: '120', icon: Iconsax.bag),
//                 _StatCard(
//                   title: 'Earnings',
//                   value: 'Rs 58,000',
//                   icon: Iconsax.wallet,
//                 ),
//                 _StatCard(title: 'Products', value: '24', icon: Iconsax.box),
//               ],
//             ),

//             const SizedBox(height: BaakasSizes.spaceBtwSections),

//             // Add Product Image Section - right below the Overview section
//             _DashboardTile(
//               icon: Iconsax.camera,
//               title: 'Upload Product Image',
//               subtitle: 'Upload an image for your product listing',
//               onTap: () {
//                 Get.to(
//                   () => const UploadProductImageScreen(),
//                 ); // Navigate to image upload screen
//               },
//             ),

//             const SizedBox(
//               height: BaakasSizes.spaceBtwSections,
//             ), // Add some spacing between sections
//             // Actions Section
//             Text('Manage', style: Theme.of(context).textTheme.titleLarge),
//             const SizedBox(height: BaakasSizes.spaceBtwItems),
//             _DashboardTile(
//               icon: Iconsax.box_add,
//               title: 'Manage Products',
//               subtitle: 'Add or update your listings',
//               onTap: () {
//                 Get.to(() => const ManageProductsScreen());
//               },
//             ),
//             _DashboardTile(
//               icon: Iconsax.bag_tick,
//               title: 'Order Management',
//               subtitle: 'View and fulfill orders',
//               onTap: () {
//                 Get.to(() => const SellerOrdersScreen());
//               },
//             ),
//             _DashboardTile(
//               icon: Iconsax.message,
//               title: 'Customer Messages',
//               subtitle: 'Chat with your buyers',
//               onTap: () {
//                 Get.to(() => const CustomerMessagesScreen());
//               },
//             ),
//             _DashboardTile(
//               icon: Iconsax.money_send,
//               title: 'Withdraw Funds',
//               subtitle: 'Request earnings payout',
//               onTap: () {
//                 Get.to(() => const WithdrawFundsScreen());
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class _StatCard extends StatelessWidget {
//   final String title;
//   final String value;
//   final IconData icon;

//   const _StatCard({
//     required this.title,
//     required this.value,
//     required this.icon,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final isDark = Theme.of(context).brightness == Brightness.dark;
//     final color = isDark ? Colors.white : Colors.black87;

//     return Expanded(
//       child: Card(
//         elevation: 2,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//         child: Padding(
//           padding: const EdgeInsets.all(BaakasSizes.md),
//           child: Column(
//             children: [
//               Icon(icon, color: BaakasColors.primaryColor, size: 28),
//               const SizedBox(height: 8),
//               Text(
//                 value,
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 18,
//                   color: color,
//                 ),
//               ),
//               const SizedBox(height: 4),
//               Text(title, style: TextStyle(fontSize: 14, color: Colors.grey)),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class _DashboardTile extends StatelessWidget {
//   final IconData icon;
//   final String title;
//   final String subtitle;
//   final VoidCallback onTap;

//   const _DashboardTile({
//     required this.icon,
//     required this.title,
//     required this.subtitle,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final isDark = Theme.of(context).brightness == Brightness.dark;

//     return Card(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//       margin: const EdgeInsets.only(bottom: BaakasSizes.spaceBtwItems),
//       child: ListTile(
//         leading: CircleAvatar(
//           backgroundColor: BaakasColors.primaryColor.withOpacity(0.1),
//           child: Icon(icon, color: BaakasColors.primaryColor),
//         ),
//         title: Text(title),
//         subtitle: Text(subtitle),
//         trailing: const Icon(Iconsax.arrow_right_3),
//         onTap: onTap,
//       ),
//     );
//   }
// }
