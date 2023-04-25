import 'package:flutter/material.dart';
import 'package:movie_app/shared_ui/colors/colors.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  final Widget? leading;
  final Widget? title;
  final bool? centerTitle;
  final double? titleSpacing;
  final Widget? actions;
  final EdgeInsets? paddingActions;
  final VoidCallback? onTapLeading;
  final double? leadingWidth;
  const CustomAppBar({
    super.key,
    this.title,
    this.actions,
    this.leading,
    this.titleSpacing,
    this.paddingActions,
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
      actions: [
        Padding(
          padding: paddingActions ?? const EdgeInsets.fromLTRB(0, 0, 15, 0),
          child: actions,
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(65);
}
