// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// class PushNotificationService {
//   final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   // Initialize the notification plugin
//   Future<void> init() async {
//     const androidInitialization = AndroidInitializationSettings(
//       '@mipmap/ic_launcher',
//     );

//     final InitializationSettings initializationSettings =
//         InitializationSettings(android: androidInitialization);

//     // Initialize local notifications with onSelectNotification handler
//     await flutterLocalNotificationsPlugin.initialize(
//       initializationSettings,
//       onSelectNotification: (String? payload) async {
//         // Handle notification tapped
//         if (payload != null) {
//           print("Notification tapped with payload: $payload");
//         } else {
//           print("Notification tapped with no payload");
//         }
//       },
//     );

//     // Request permission for iOS
//     await _firebaseMessaging.requestPermission();

//     // Set foreground message listener
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       _showNotification(message);
//     });

//     // Optionally handle background and terminated messages
//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       // Handle when notification is tapped
//       print("Notification tapped: ${message.data}");
//     });

//     // Get and print FCM Token
//     String? token = await _firebaseMessaging.getToken();
//     print("🔔 FCM Token: $token");
//   }

//   // Show notification when app is in foreground
//   Future<void> _showNotification(RemoteMessage message) async {
//     const androidDetails = AndroidNotificationDetails(
//       'high_importance_channel',
//       'High Importance Notifications',
//       channelDescription: 'This channel is used for important notifications.',
//       importance: Importance.max,
//       priority: Priority.high,
//       ticker: 'ticker',
//     );

//     const platformDetails = NotificationDetails(android: androidDetails);

//     await flutterLocalNotificationsPlugin.show(
//       message.hashCode,
//       message.notification?.title ?? 'No Title',
//       message.notification?.body ?? 'No Body',
//       platformDetails,
//     );
//   }
// }
