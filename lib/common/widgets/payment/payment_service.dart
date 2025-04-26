// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:url_launcher/url_launcher.dart';

// Future<void> initiateEsewaPayment(double amount, String productId, String userId) async {
//   final response = await http.post(
//     Uri.parse('http://<your_server_ip>:5000/initiate-payment'), // Replace with your Node.js backend URL
//     body: {
//       'amount': amount.toString(),
//       'productId': productId,
//       'userId': userId,
//     },
//   );

//   if (response.statusCode == 200) {
//     final redirectUrl = jsonDecode(response.body)['redirect_url'];
//     if (await canLaunchUrl(Uri.parse(redirectUrl))) {
//       await launchUrl(Uri.parse(redirectUrl), mode: LaunchMode.externalApplication);
//     } else {
//       throw Exception('Could not launch URL');
//     }
//   } else {
//     throw Exception('Failed to initiate payment');
//   }
// }

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

Future<void> initiateEsewaPayment(
  double amount,
  String productId,
  String userId,
  String password,
) async {
  final response = await http.post(
    Uri.parse(
      'http://<your_server_ip>:5000/initiate-payment',
    ), // Replace with actual IP or domain
    headers: {
      'Content-Type': 'application/json',
    }, // ✅ Always send headers for JSON
    body: jsonEncode({
      'amount': amount.toString(),
      'productId': productId,
      'userId': userId,
    }),
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);

    if (data.containsKey('redirect_url')) {
      final redirectUrl = data['redirect_url'];
      final uri = Uri.parse(redirectUrl);

      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        throw Exception('Could not launch URL: $redirectUrl');
      }
    } else {
      throw Exception('redirect_url not found in response');
    }
  } else {
    throw Exception('Failed to initiate payment: ${response.statusCode}');
  }
}
