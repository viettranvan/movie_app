import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/shared_ui/colors/color.dart';

class PrimaryText extends StatelessWidget {
  final String title;
  final bool? visibleIcon;
  final Widget? icon;
  final bool? visibleViewAll;
  final VoidCallback? onTapViewAll;
  const PrimaryText({
    super.key,
    this.visibleIcon,
    this.icon,
    this.visibleViewAll,
    this.onTapViewAll,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(17.w, 0, 10.w, 0),
          child: icon,
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 20.w, 0),
          child: Text(
            title,
            textScaleFactor: 1,
            style: TextStyle(
              letterSpacing: 0.2,
              fontWeight: FontWeight.w500,
              fontSize: 20.sp,
              color: greyColor,
            ),
          ),
        ),
        const Spacer(),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 8.h),
            Visibility(
              visible: visibleViewAll ?? false,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: onTapViewAll,
                    child: Text(
                      'View all',
                      textScaleFactor: 1,
                      style: TextStyle(
                        letterSpacing: 0.2,
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                        color: greyColor,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 17.w, 0),
                    child: RotatedBox(
                      quarterTurns: 2,
                      child: Icon(
                        Icons.arrow_back_ios,
                        size: 10.sp,
                        color: greyColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
