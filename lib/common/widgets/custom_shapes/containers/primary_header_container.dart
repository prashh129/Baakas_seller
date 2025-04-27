import 'package:flutter/material.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';

/// A container widget with a primary color background and curved edges.
class BaakasPrimaryHeaderContainer extends StatelessWidget {
  /// Create a container with a primary color background and curved edges.
  ///
  /// Parameters:
  ///   - child: The widget to be placed inside the container.
  const BaakasPrimaryHeaderContainer({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: BaakasColors.primaryColor,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(BaakasSizes.cardRadiusLg),
          bottomRight: Radius.circular(BaakasSizes.cardRadiusLg),
        ),
      ),
      child: Stack(
        children: [
          /// -- Background Custom Shapes
          Positioned(
            top: -20,
            right: -20,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: BaakasColors.white.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            top: 100,
            left: -30,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: BaakasColors.white.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
            ),
          ),
          child,
        ],
      ),
    );
  }
}
