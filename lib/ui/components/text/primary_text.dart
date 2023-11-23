import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/shared_ui/colors/color.dart';

class PrimaryText extends StatelessWidget {
  final String title;
  final Widget? icon;
  final bool? hasSwitch;
  final Widget? child;
  final bool? visibleIcon;
  final VoidCallback? onTapViewAll;

  const PrimaryText({
    super.key,
    this.icon,
    this.hasSwitch,
    this.onTapViewAll,
    required this.title,
    this.child,
    this.visibleIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(17.w, 0, 17.w, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Visibility(
            visible: visibleIcon ?? false,
            child: Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 10.w, 0),
              child: icon ?? const SizedBox(),
            ),
          ),
          Text(
            title,
            textScaleFactor: 1,
            style: TextStyle(
              letterSpacing: 0.2,
              fontWeight: FontWeight.w500,
              fontSize: 18.5.sp,
              color: greyColor,
            ),
          ),
          const Spacer(),
          hasSwitch ?? false
              ? child ?? const SizedBox()
              : GestureDetector(
                  onTap: onTapViewAll,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'View all',
                          textScaleFactor: 1,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14.sp,
                            color: darkBlueColor,
                          ),
                        ),
                        Icon(
                          Icons.arrow_back_ios,
                          size: 10.sp,
                          color: darkBlueColor,
                          textDirection: TextDirection.rtl,
                        ),
                      ],
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
