import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/shared_ui/colors/color.dart';

class SecondaryText extends StatelessWidget {
  final String title;
  final Widget? leftWidget;
  final Widget? icon;
  final bool? visibleViewAll;
  final VoidCallback? onTapViewAll;
  const SecondaryText({
    super.key,
    this.icon,
    this.visibleViewAll,
    this.onTapViewAll,
    required this.title,
    this.leftWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(17.w, 0, 20.w, 0),
          child: Text(
            title,
            textScaleFactor: 1,
            style: TextStyle(
              letterSpacing: 0.2,
              fontWeight: FontWeight.w500,
              fontSize: 15.sp,
              color: greyColor,
            ),
          ),
        ),
        const Spacer(),
        leftWidget ?? const SizedBox(),
      ],
    );
  }
}
