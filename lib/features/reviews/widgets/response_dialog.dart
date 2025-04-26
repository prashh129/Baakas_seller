import 'package:flutter/material.dart';
import 'package:baakas_seller/utils/constants/sizes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ResponseDialog extends StatelessWidget {
  final String customerName;
  final String reviewText;
  final String reviewId;

  const ResponseDialog({
    super.key,
    required this.customerName,
    required this.reviewText,
    required this.reviewId,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController responseController = TextEditingController();
    final String? currentUserId = FirebaseAuth.instance.currentUser?.uid;

    return Dialog(
      backgroundColor: const Color(0xFF424242),
      child: Padding(
        padding: const EdgeInsets.all(BaakasSizes.defaultSpace),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Respond to $customerName\'s Review',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: BaakasSizes.spaceBtwItems),
            const Text(
              'Review:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: BaakasSizes.spaceBtwItems / 2),
            Text(reviewText, style: const TextStyle(color: Colors.white)),
            const SizedBox(height: BaakasSizes.spaceBtwItems),
            TextField(
              controller: responseController,
              maxLines: 4,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Type your response here...',
                hintStyle: const TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(BaakasSizes.sm),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(BaakasSizes.sm),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(BaakasSizes.sm),
                  borderSide: const BorderSide(color: Colors.deepPurple),
                ),
              ),
            ),
            const SizedBox(height: BaakasSizes.spaceBtwItems),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                const SizedBox(width: BaakasSizes.spaceBtwItems),
                ElevatedButton(
                  onPressed: () {
                    if (currentUserId == null) return;

                    FirebaseFirestore.instance
                        .collection('Sellers')
                        .doc(currentUserId)
                        .collection('reviews')
                        .doc(reviewId)
                        .update({
                          'response': responseController.text,
                          'responseTimestamp': FieldValue.serverTimestamp(),
                          'isUnread': false,
                        })
                        .then((_) {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Response sent successfully!'),
                              backgroundColor: Colors.green,
                            ),
                          );
                        })
                        .catchError((e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Error sending response: $e'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                  ),
                  child: const Text('Send Response'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
