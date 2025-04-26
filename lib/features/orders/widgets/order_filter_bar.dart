import 'package:flutter/material.dart';
import 'package:baakas_seller/utils/constants/colors.dart';

class OrderFilterBar extends StatefulWidget {
  final Function(String) onFilterChanged;
  final bool isDark;

  const OrderFilterBar({
    super.key,
    required this.onFilterChanged,
    required this.isDark,
  });

  @override
  State<OrderFilterBar> createState() => _OrderFilterBarState();
}

class _OrderFilterBarState extends State<OrderFilterBar> {
  String selectedFilter = 'all';

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Colors.orange;
      case 'shipped':
        return Colors.blue;
      case 'delivered':
        return Colors.green;
      case 'canceled':
        return Colors.red;
      default:
        return BaakasColors.primaryColor;
    }
  }

  Widget _buildFilterChip(String label, String value) {
    final isSelected = selectedFilter == value;
    final color = _getStatusColor(value);

    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(
          label,
          style: TextStyle(
            color:
                isSelected
                    ? (widget.isDark ? Colors.white : Colors.black)
                    : Colors.grey[400],
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        selected: isSelected,
        onSelected: (_) {
          setState(() => selectedFilter = value);
          widget.onFilterChanged(value);
        },
        backgroundColor: widget.isDark ? const Color(0xFF1E1E1E) : Colors.grey[100],
        selectedColor: color.withOpacity(0.3),
        checkmarkColor: Colors.transparent,
        showCheckmark: false,
        elevation: 0,
        pressElevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
          side: BorderSide(
            color:
                isSelected
                    ? color
                    : (widget.isDark ? Colors.grey[800]! : Colors.grey[300]!),
            width: 1,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildFilterChip('All', 'all'),
          _buildFilterChip('Pending', 'pending'),
          _buildFilterChip('Shipped', 'shipped'),
          _buildFilterChip('Delivered', 'delivered'),
          _buildFilterChip('Canceled', 'canceled'),
        ],
      ),
    );
  }
}
