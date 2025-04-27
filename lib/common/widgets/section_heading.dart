import 'package:flutter/material.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/sizes.dart';

class BaakasSectionHeading extends StatelessWidget {
  const BaakasSectionHeading({
    super.key,
    required this.title,
    this.showActionButton = true,
    this.buttonTitle = 'View All',
    this.onPressed,
    this.textColor,
  });

  final String title;
  final bool showActionButton;
  final String buttonTitle;
  final VoidCallback? onPressed;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headlineSmall?.apply(
                color: textColor,
                fontWeightDelta: 2,
              ),
        ),
        if (showActionButton)
          TextButton(
            onPressed: onPressed,
            child: Text(
              buttonTitle,
              style: Theme.of(context).textTheme.bodyMedium?.apply(
                    color: BaakasColors.primaryColor,
                  ),
            ),
          ),
      ],
    );
  }
} 