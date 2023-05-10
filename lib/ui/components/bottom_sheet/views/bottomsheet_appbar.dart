import 'package:flutter/material.dart';
import 'package:movie_app/shared_ui/colors/colors.dart';
import 'package:movie_app/shared_ui/index.dart';

class BottomSheetAppBar extends StatelessWidget {
  const BottomSheetAppBar({
    Key? key,
    required this.title,
    this.leading,
    this.trailing,
    this.titleColor,
    this.toolbarHeight,
  }) : super(key: key);

  final String title;
  final Widget? leading;
  final Widget? trailing;
  final Color? titleColor;
  final double? toolbarHeight;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
      child: AppBar(
        toolbarHeight: toolbarHeight ?? 44,
        bottomOpacity: 0.0,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          title,
          style: AppStyles.body02.copyWith(
            color: AppColors.black,
          ),
        ),
        backgroundColor: AppColors.white,
        leading: leading ??
            InkWell(
              onTap: () => Navigator.of(context).pop(),
              child: Image.asset(
                ImagesPath.backIcon.assetName,
                width: 24,
                height: 24,
                color: AppColors.textPrimary,
              ),
            ),
        leadingWidth: 24,
        actions: trailing != null ? [trailing!] : [],
      ),
    );
  }
}
