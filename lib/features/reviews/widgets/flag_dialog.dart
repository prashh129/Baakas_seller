import 'package:flutter/material.dart';
import 'package:baakas_seller/utils/constants/sizes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FlagDialog extends StatefulWidget {
  final String customerName;
  final String reviewText;
  final String reviewId;

  const FlagDialog({
    super.key,
    required this.customerName,
    required this.reviewText,
    required this.reviewId,
  });

  @override
  State<FlagDialog> createState() => _FlagDialogState();
}

class _FlagDialogState extends State<FlagDialog> {
  String? _selectedReason;
  final String? _currentUserId = FirebaseAuth.instance.currentUser?.uid;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color(0xFF424242),
      child: Padding(
        padding: const EdgeInsets.all(BaakasSizes.defaultSpace),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Flag ${widget.customerName}\'s Review',
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
            Text(widget.reviewText, style: const TextStyle(color: Colors.white)),
            const SizedBox(height: BaakasSizes.spaceBtwItems),
            const Text(
              'Reason for flagging:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: BaakasSizes.spaceBtwItems / 2),
            ...['Spam', 'Inappropriate Content', 'Fake Review', 'Other']
                .map(
                  (reason) => RadioListTile<String>(
                    title: Text(
                      reason,
                      style: const TextStyle(color: Colors.white),
                    ),
                    value: reason,
                    groupValue: _selectedReason,
                    onChanged: (value) {
                      setState(() {
                        _selectedReason = value;
                      });
                    },
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
                  onPressed: _selectedReason == null ? null : () {
                    if (_currentUserId == null) return;

                    FirebaseFirestore.instance
                        .collection('Sellers')
                        .doc(_currentUserId)
                        .collection('reviews')
                        .doc(widget.reviewId)
                        .update({
                          'isFlagged': true,
                          'flagReason': _selectedReason,
                          'flagTimestamp': FieldValue.serverTimestamp(),
                        })
                        .then((_) {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Review flagged successfully!'),
                              backgroundColor: Colors.green,
                            ),
                          );
                        })
                        .catchError((e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Error flagging review: $e'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                  ),
                  child: const Text('Submit Flag'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
