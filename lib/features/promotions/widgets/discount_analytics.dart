import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DiscountAnalytics extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String? _currentUserId = FirebaseAuth.instance.currentUser?.uid;

  DiscountAnalytics({super.key});

  @override
  Widget build(BuildContext context) {
    if (_currentUserId == null) {
      return Center(
        child: Text(
          'Please sign in to view analytics',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      );
    }

    return StreamBuilder<QuerySnapshot>(
      stream:
          _firestore
              .collection('Sellers')
              .doc(_currentUserId)
              .collection('promotions')
              .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(
              'Error: ${snapshot.error}',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final promotions = snapshot.data?.docs ?? [];
        final totalDiscount = _calculateTotalDiscount(promotions);
        final activeCoupons = _countActiveCoupons(promotions);
        final seasonalOffers = _countSeasonalOffers(promotions);
        final recentActivity = _getRecentActivity(promotions);

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildAnalyticsCard(
                context,
                'Total Discounts Given',
                'Rs ${totalDiscount.toStringAsFixed(2)}',
                '+15.2%',
                Iconsax.money_tick,
                Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 16),
              _buildAnalyticsCard(
                context,
                'Active Coupons',
                activeCoupons.toString(),
                '+2 new',
                Iconsax.discount_shape,
                Theme.of(context).colorScheme.secondary,
              ),
              const SizedBox(height: 16),
              _buildAnalyticsCard(
                context,
                'Seasonal Offers',
                seasonalOffers.toString(),
                '1 ending soon',
                Iconsax.calendar,
                Theme.of(context).colorScheme.tertiary,
              ),
              const SizedBox(height: 24),
              Text(
                'Recent Activity',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              ...recentActivity.map(
                (activity) => _buildActivityItem(
                  context,
                  activity['title'] ?? '',
                  activity['description'] ?? '',
                  activity['time'] ?? '',
                  _getIconForActivity(activity['type'] ?? ''),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  double _calculateTotalDiscount(List<QueryDocumentSnapshot> promotions) {
    double total = 0;
    for (var doc in promotions) {
      final data = doc.data() as Map<String, dynamic>;
      if (data['type'] == 'coupon') {
        total += (data['discount'] ?? 0) * (data['usageCount'] ?? 0);
      }
    }
    return total;
  }

  int _countActiveCoupons(List<QueryDocumentSnapshot> promotions) {
    return promotions.where((doc) {
      final data = doc.data() as Map<String, dynamic>;
      return data['type'] == 'coupon' && data['isActive'] == true;
    }).length;
  }

  int _countSeasonalOffers(List<QueryDocumentSnapshot> promotions) {
    return promotions.where((doc) {
      final data = doc.data() as Map<String, dynamic>;
      return data['type'] == 'seasonal' && data['isActive'] == true;
    }).length;
  }

  List<Map<String, dynamic>> _getRecentActivity(
    List<QueryDocumentSnapshot> promotions,
  ) {
    final activities = <Map<String, dynamic>>[];

    for (var doc in promotions) {
      final data = doc.data() as Map<String, dynamic>;
      final timestamp = data['lastUpdated'] as Timestamp?;
      if (timestamp != null) {
        activities.add({
          'title': data['code'] ?? data['title'] ?? '',
          'description': _getActivityDescription(data),
          'time': _formatTimestamp(timestamp),
          'type': data['type'] ?? 'coupon',
        });
      }
    }

    activities.sort((a, b) => b['time'].compareTo(a['time']));
    return activities.take(5).toList();
  }

  String _getActivityDescription(Map<String, dynamic> data) {
    if (data['type'] == 'coupon') {
      return 'Used by ${data['usageCount'] ?? 0} customers';
    } else if (data['type'] == 'seasonal') {
      return 'Active until ${_formatDate(data['endDate'] as Timestamp?)}';
    }
    return 'Updated';
  }

  String _formatTimestamp(Timestamp timestamp) {
    final now = DateTime.now();
    final date = timestamp.toDate();
    final difference = now.difference(date);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inHours < 1) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inDays < 1) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }

  String _formatDate(Timestamp? timestamp) {
    if (timestamp == null) return '';
    final date = timestamp.toDate();
    return '${date.day}/${date.month}/${date.year}';
  }

  IconData _getIconForActivity(String type) {
    switch (type) {
      case 'coupon':
        return Iconsax.discount_shape;
      case 'seasonal':
        return Iconsax.calendar;
      default:
        return Iconsax.info_circle;
    }
  }

  Widget _buildAnalyticsCard(
    BuildContext context,
    String title,
    String value,
    String change,
    IconData icon,
    Color color,
  ) {
    return Card(
      color: Theme.of(context).cardColor,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 51),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(
                        context,
                      ).textTheme.bodyLarge?.color?.withValues(alpha: 179),
                    ),
                  ),
                  Text(
                    value,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              change,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityItem(
    BuildContext context,
    String title,
    String description,
    String time,
    IconData icon,
  ) {
    return Card(
      color: Theme.of(context).cardColor,
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withValues(alpha: 51),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: Theme.of(context).primaryColor,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    description,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(
                        context,
                      ).textTheme.bodyLarge?.color?.withValues(alpha: 179),
                    ),
                  ),
                ],
              ),
            ),
            Text(
              time,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(
                  context,
                ).textTheme.bodyLarge?.color?.withValues(alpha: 128),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
