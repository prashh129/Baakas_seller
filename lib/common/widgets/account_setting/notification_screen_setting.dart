import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../common/widgets/appbar/appbar.dart';
import 'package:logger/logger.dart';

class NotificationScreenSetting extends StatefulWidget {
  const NotificationScreenSetting({super.key});

  @override
  State<NotificationScreenSetting> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreenSetting> {
  final _logger = Logger();
  bool orderUpdates = true;
  bool withdrawalAlerts = true;
  bool adminMessages = true;

  final String? userId = FirebaseAuth.instance.currentUser?.uid;

  @override
  void initState() {
    super.initState();
    _loadNotificationSettings();
  }

  Future<void> _loadNotificationSettings() async {
    if (userId == null) return;

    try {
      final snapshot =
          await FirebaseFirestore.instance
              .collection('Sellers')
              .doc(userId)
              .collection('settings')
              .doc('notifications')
              .get();

      if (snapshot.exists) {
        final data = snapshot.data()!;
        setState(() {
          orderUpdates = data['orderUpdates'] ?? true;
          withdrawalAlerts = data['withdrawalAlerts'] ?? true;
          adminMessages = data['adminMessages'] ?? true;
        });
      }
    } catch (e) {
      _logger.e("Error loading notification settings: $e");
    }
  }

  Future<void> _updateNotificationSettings() async {
    if (userId == null) return;

    try {
      await FirebaseFirestore.instance
          .collection('Sellers')
          .doc(userId)
          .collection('settings')
          .doc('notifications')
          .set({
            'orderUpdates': orderUpdates,
            'withdrawalAlerts': withdrawalAlerts,
            'adminMessages': adminMessages,
          }, SetOptions(merge: true));

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Notification settings updated.'),
          duration: Duration(seconds: 1),
        ),
      );
    } catch (e) {
      _logger.e("Error updating settings: $e");
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to update notification settings.'),
          duration: Duration(seconds: 1),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BaakasAppBar(
        showBackArrow: true,
        title: Text("Notification Settings"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSwitchTile(
            title: "Order Status Updates",
            subtitle:
                "Get notified when a new order is placed or status changes.",
            value: orderUpdates,
            onChanged: (val) {
              setState(() => orderUpdates = val);
              _updateNotificationSettings();
            },
          ),
          _buildSwitchTile(
            title: "Withdrawal Alerts",
            subtitle:
                "Get notified when your withdrawal requests are processed.",
            value: withdrawalAlerts,
            onChanged: (val) {
              setState(() => withdrawalAlerts = val);
              _updateNotificationSettings();
            },
          ),
          _buildSwitchTile(
            title: "Admin Messages",
            subtitle: "Receive important updates or notices from the admin.",
            value: adminMessages,
            onChanged: (val) {
              setState(() => adminMessages = val);
              _updateNotificationSettings();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required String subtitle,
    required bool value,
    required void Function(bool) onChanged,
  }) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      value: value,
      activeColor: Colors.green,
      onChanged: onChanged,
    );
  }
}
