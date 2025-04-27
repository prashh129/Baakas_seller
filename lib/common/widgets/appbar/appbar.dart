import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/device/device_utility.dart';
import '../../../utils/helpers/helper_functions.dart';

class BaakasAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// Custom appbar for achieving a desired design goal.
  /// - Set [title] for a custom title.
  /// - [showBackArrow] to toggle the visibility of the back arrow.
  /// - [leadingIcon] for a custom leading icon.
  /// - [leadingOnPressed] callback for the leading icon press event.
  /// - [actions] for adding a list of action widgets.
  /// - Horizontal padding of the appbar can be customized inside this widget.
  const BaakasAppBar({
    super.key,
    this.title,
    this.actions,
    this.leadingIcon,
    this.leadingOnPressed,
    this.showBackArrow = false,
    this.backgroundColor,
    this.elevation = 0,
    // required int width, i comment this section to check the code
    // required int height, this section too
  });

  final Widget? title;
  final bool showBackArrow;
  final IconData? leadingIcon;
  final List<Widget>? actions;
  final VoidCallback? leadingOnPressed;
  final Color? backgroundColor;
  final double elevation;

  @override
  Widget build(BuildContext context) {
    final darkMode = BaakasHelperFunctions.isDarkMode(context);
    final theme = Theme.of(context);

    return AppBar(
      automaticallyImplyLeading: false,
      leading: showBackArrow
          ? IconButton(
              onPressed: () => Get.back(),
              icon: Icon(
                Icons.arrow_back_ios,
                color: darkMode ? BaakasColors.white : BaakasColors.black,
              ),
            )
          : leadingIcon != null
              ? IconButton(
                  onPressed: leadingOnPressed,
                  icon: Icon(leadingIcon),
                )
              : null,
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: BaakasSizes.xs),
        child: title,
      ),
      actions: actions,
      backgroundColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      surfaceTintColor: Colors.transparent,
      shadowColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(16),
        ),
      ),
      iconTheme: theme.appBarTheme.iconTheme,
      actionsIconTheme: theme.appBarTheme.actionsIconTheme,
      titleTextStyle: theme.appBarTheme.titleTextStyle,
      toolbarHeight: BaakasSizes.appBarHeight + 8, // Slightly taller for better spacing
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(BaakasDeviceUtils.getAppBarHeight() + 8);
}
