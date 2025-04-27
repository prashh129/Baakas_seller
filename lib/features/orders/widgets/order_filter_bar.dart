import 'package:flutter/material.dart';
import 'package:baakas_seller/utils/constants/colors.dart';
import 'package:baakas_seller/utils/constants/sizes.dart';
import 'package:iconsax/iconsax.dart';

class OrderFilterBar extends StatelessWidget {
  final String selectedFilter;
  final Function(String) onFilterSelected;
  final bool isDark;

  const OrderFilterBar({
    super.key,
    required this.selectedFilter,
    required this.onFilterSelected,
    required this.isDark,
  });

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Colors.orange;
      case 'processing':
        return Colors.blue;
      case 'shipped':
        return Colors.purple;
      case 'delivered':
        return Colors.green;
      case 'canceled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Iconsax.timer_1;
      case 'processing':
        return Iconsax.box_1;
      case 'shipped':
        return Iconsax.truck;
      case 'delivered':
        return Iconsax.verify;
      case 'canceled':
        return Iconsax.close_circle;
      default:
        return Iconsax.box;
    }
  }

  Widget _buildFilterChip(String label, String value) {
    final isSelected = selectedFilter == value;
    final color = _getStatusColor(value);
    final icon = _getStatusIcon(value);

    return FilterChip(
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 16,
            color: isSelected ? Colors.white : color,
          ),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : color,
              fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
            ),
          ),
        ],
      ),
      selected: isSelected,
      onSelected: (selected) {
        if (selected) {
          onFilterSelected(value);
        }
      },
      backgroundColor: color.withOpacity(0.1),
      selectedColor: color,
      checkmarkColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(
          color: isSelected ? color : Colors.transparent,
          width: 1,
        ),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: BaakasSizes.sm,
        vertical: BaakasSizes.xs,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(
        horizontal: BaakasSizes.md,
        vertical: BaakasSizes.sm,
      ),
      child: Row(
        children: [
          _buildFilterChip('All', 'all'),
          const SizedBox(width: BaakasSizes.sm),
          _buildFilterChip('Pending', 'pending'),
          const SizedBox(width: BaakasSizes.sm),
          _buildFilterChip('Processing', 'processing'),
          const SizedBox(width: BaakasSizes.sm),
          _buildFilterChip('Shipped', 'shipped'),
          const SizedBox(width: BaakasSizes.sm),
          _buildFilterChip('Delivered', 'delivered'),
          const SizedBox(width: BaakasSizes.sm),
          _buildFilterChip('Canceled', 'canceled'),
        ],
      ),
    );
  }
}
