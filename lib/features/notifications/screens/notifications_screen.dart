import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../common/widgets/appbar/appbar.dart';
import '../widgets/notification_list.dart';
import '../controllers/notifications_controller.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NotificationsController());

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(120),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const BaakasAppBar(
                  showBackArrow: true,
                  title: Text('Notifications'),
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
                      Tab(icon: Icon(Iconsax.shopping_cart), text: 'Orders'),
                      Tab(icon: Icon(Iconsax.message), text: 'Chat'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        body: const TabBarView(
          children: [
            NotificationList(type: 'order'),
            NotificationList(type: 'chat'),
          ],
        ),
      ),
    );
  }
}
