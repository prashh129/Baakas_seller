import 'package:baakas_seller/common/widgets/account_setting/message/chat.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class CustomerMessagesScreen extends StatelessWidget {
  const CustomerMessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final buyers = [
      {'name': 'Aayusha Lama', 'message': 'Is this still available?'},
      {'name': 'Rabin Thapa', 'message': 'Can I get this in blue?'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Customer Messages'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: isDark ? Colors.white : Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: buyers.length,
        itemBuilder: (context, index) {
          final buyer = buyers[index];
          return ListTile(
            leading: CircleAvatar(child: Text(buyer['name']![0])),
            title: Text(buyer['name']!),
            subtitle: Text(buyer['message']!),
            trailing: const Icon(Iconsax.message),
            onTap: () => Get.to(() => ChatScreen(sellerName: buyer['name']!)),
          );
        },
      ),
    );
  }
}
