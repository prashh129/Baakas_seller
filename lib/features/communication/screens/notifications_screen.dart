import 'package:flutter/material.dart';
import '../../../common/widgets/appbar/appbar.dart';
import '../widgets/notifications_list.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: const BaakasAppBar(
        showBackArrow: true,
        title: Text('Notifications'),
      ),
      body: const NotificationsList(),
    );
  }
}
