import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:baakas_seller/utils/constants/colors.dart';
import 'package:baakas_seller/utils/constants/sizes.dart';
import '../screens/reviews_screen.dart';

class ReviewList extends StatelessWidget {
  final ReviewFilter filter;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String? _currentUserId = FirebaseAuth.instance.currentUser?.uid;

  ReviewList({super.key, this.filter = ReviewFilter.all});

  @override
  Widget build(BuildContext context) {
    if (_currentUserId == null) {
      return const Center(
        child: Text(
          'Please sign in to view reviews',
          style: TextStyle(color: Colors.white),
        ),
      );
    }

    return StreamBuilder<QuerySnapshot>(
      stream: _getReviewsStream(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(
              'Error loading reviews: ${snapshot.error}',
              style: const TextStyle(color: Colors.red),
            ),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final reviews = snapshot.data?.docs ?? [];

        if (reviews.isEmpty) {
          return const Center(
            child: Text(
              'No reviews found',
              style: TextStyle(color: Colors.white),
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(BaakasSizes.defaultSpace),
          itemCount: reviews.length,
          itemBuilder: (context, index) {
            final review = reviews[index].data() as Map<String, dynamic>;
            return ReviewCard(
              customerName: review['customerName'] ?? 'Anonymous',
              rating: (review['rating'] ?? 0.0).toDouble(),
              reviewText: review['reviewText'] ?? '',
              date: _formatDate(review['timestamp']),
              isUnread: review['isUnread'] ?? false,
              hasResponse: review['response'] != null,
              reviewId: reviews[index].id,
              response: review['response'],
            );
          },
        );
      },
    );
  }

  Stream<QuerySnapshot> _getReviewsStream() {
    final reviewsRef = _firestore
        .collection('Sellers')
        .doc(_currentUserId)
        .collection('reviews');

    switch (filter) {
      case ReviewFilter.unread:
        return reviewsRef.where('isUnread', isEqualTo: true).snapshots();
      case ReviewFilter.responded:
        return reviewsRef.where('response', isNull: false).snapshots();
      default:
        return reviewsRef.orderBy('timestamp', descending: true).snapshots();
    }
  }

  String _formatDate(dynamic timestamp) {
    if (timestamp == null) return 'Unknown date';

    final date =
        timestamp is Timestamp
            ? timestamp.toDate()
            : DateTime.parse(timestamp.toString());

    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      if (difference.inHours == 0) {
        return '${difference.inMinutes} minutes ago';
      }
      return '${difference.inHours} hours ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }
}

class ReviewCard extends StatefulWidget {
  final String customerName;
  final double rating;
  final String reviewText;
  final String date;
  final bool isUnread;
  final bool hasResponse;
  final String reviewId;
  final String? response;

  const ReviewCard({
    super.key,
    required this.customerName,
    required this.rating,
    required this.reviewText,
    required this.date,
    this.isUnread = false,
    this.hasResponse = false,
    required this.reviewId,
    this.response,
  });

  @override
  State<ReviewCard> createState() => _ReviewCardState();
}

class _ReviewCardState extends State<ReviewCard> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String? _currentUserId = FirebaseAuth.instance.currentUser?.uid;

  Future<void> _showResponseDialog(BuildContext context) async {
    final TextEditingController responseController = TextEditingController(
      text: widget.response ?? '',
    );

    return showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: const Color(0xFF424242),
        title: Text(
          'Respond to ${widget.customerName}\'s Review',
          style: const TextStyle(color: Colors.white),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
            TextField(
              controller: responseController,
              style: const TextStyle(color: Colors.white),
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: 'Your Response',
                labelStyle: TextStyle(color: Colors.grey),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (_currentUserId == null) return;

              _firestore
                  .collection('Sellers')
                  .doc(_currentUserId)
                  .collection('reviews')
                  .doc(widget.reviewId)
                  .update({
                    'response': responseController.text,
                    'responseTimestamp': FieldValue.serverTimestamp(),
                    'isUnread': false,
                  })
                  .then((_) {
                    if (dialogContext.mounted) {
                      Navigator.pop(dialogContext);
                      ScaffoldMessenger.of(dialogContext).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Response sent successfully!',
                            style: TextStyle(color: Colors.white),
                          ),
                          backgroundColor: Colors.green,
                        ),
                      );
                    }
                  })
                  .catchError((e) {
                    if (dialogContext.mounted) {
                      ScaffoldMessenger.of(dialogContext).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Error sending response: $e',
                            style: const TextStyle(color: Colors.white),
                          ),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  });
            },
            child: const Text('Send'),
          ),
        ],
      ),
    );
  }

  Future<void> _showFlagDialog(BuildContext context) async {
    final TextEditingController reasonController = TextEditingController();

    return showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: const Color(0xFF424242),
        title: Text(
          'Flag ${widget.customerName}\'s Review',
          style: const TextStyle(color: Colors.white),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
            TextField(
              controller: reasonController,
              style: const TextStyle(color: Colors.white),
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Reason',
                labelStyle: TextStyle(color: Colors.grey),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (_currentUserId == null || reasonController.text.isEmpty) return;

              _firestore
                  .collection('Sellers')
                  .doc(_currentUserId)
                  .collection('reviews')
                  .doc(widget.reviewId)
                  .update({
                    'isFlagged': true,
                    'flagReason': reasonController.text,
                    'flagTimestamp': FieldValue.serverTimestamp(),
                  })
                  .then((_) {
                    if (dialogContext.mounted) {
                      Navigator.pop(dialogContext);
                      ScaffoldMessenger.of(dialogContext).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Review flagged successfully!',
                            style: TextStyle(color: Colors.white),
                          ),
                          backgroundColor: Colors.green,
                        ),
                      );
                    }
                  })
                  .catchError((e) {
                    if (dialogContext.mounted) {
                      ScaffoldMessenger.of(dialogContext).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Error flagging review: $e',
                            style: const TextStyle(color: Colors.white),
                          ),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  });
            },
            child: const Text('Flag'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF424242),
      margin: const EdgeInsets.only(bottom: BaakasSizes.spaceBtwItems),
      child: Padding(
        padding: const EdgeInsets.all(BaakasSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: BaakasColors.primaryColor.withValues(alpha: 26),
                  child: const Icon(Iconsax.user),
                ),
                const SizedBox(width: BaakasSizes.spaceBtwItems),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.customerName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Row(
                        children: [
                          ...List.generate(
                            5,
                            (index) => Icon(
                              index < widget.rating.floor()
                                  ? Icons.star
                                  : Icons.star_border,
                              color: Colors.amber,
                              size: 16,
                            ),
                          ),
                          const SizedBox(width: BaakasSizes.spaceBtwItems),
                          Text(
                            widget.date,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                if (widget.isUnread)
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                    child: const Text(
                      '1',
                      style: TextStyle(color: Colors.white, fontSize: 10),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: BaakasSizes.spaceBtwItems),
            Text(widget.reviewText, style: const TextStyle(color: Colors.white)),
            if (widget.hasResponse && widget.response != null) ...[
              const SizedBox(height: BaakasSizes.spaceBtwItems),
              Container(
                padding: const EdgeInsets.all(BaakasSizes.sm),
                decoration: BoxDecoration(
                  color: Colors.deepPurple.withValues(alpha: 26),
                  borderRadius: BorderRadius.circular(BaakasSizes.sm),
                ),
                child: Text(
                  'Your response: ${widget.response}',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
            const SizedBox(height: BaakasSizes.spaceBtwItems),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton.icon(
                  onPressed: () => _showResponseDialog(context),
                  icon: const Icon(Iconsax.message, color: Colors.white),
                  label: const Text(
                    'Respond',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(width: BaakasSizes.spaceBtwItems),
                TextButton.icon(
                  onPressed: () => _showFlagDialog(context),
                  icon: const Icon(Iconsax.flag, color: Colors.white),
                  label: const Text(
                    'Flag',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
