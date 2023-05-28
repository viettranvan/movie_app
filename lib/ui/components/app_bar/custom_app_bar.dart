import 'package:flutter/material.dart';
import 'package:movie_app/shared_ui/colors/color.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? leading;
  final Widget? title;
  final bool? centerTitle;
  final double? titleSpacing;
  final List<Widget>? actions;

  final VoidCallback? onTapLeading;
  final double? leadingWidth;
  const CustomAppBar({
    super.key,
    this.title,
    this.actions,
    this.leading,
    this.titleSpacing,
    this.centerTitle,
    this.onTapLeading,
    this.leadingWidth,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      title: title,
      centerTitle: centerTitle,
      titleSpacing: titleSpacing,
      leadingWidth: leadingWidth,
      backgroundColor: darkBlueColor,
      leading: GestureDetector(
        onTap: onTapLeading,
        child: leading,
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(65);
}
