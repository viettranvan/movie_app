import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/shared_ui/colors/color.dart';
import 'package:movie_app/ui/components/components.dart';

class PrimaryText extends StatelessWidget {
  final String title;
  final Widget? icon;
  final bool? hasSwitch;
  final bool? isActive;
  final VoidCallback? onTapViewAll;
  final VoidCallback? onSwitchMovie;
  final VoidCallback? onSwitchTV;

  const PrimaryText({
    super.key,
    this.icon,
    this.hasSwitch,
    this.onTapViewAll,
    required this.title,
    this.onSwitchMovie,
    this.onSwitchTV,
    this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(17.w, 0, 17.w, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          icon ?? const SizedBox(),
          SizedBox(width: hasSwitch ?? false ? 0 : 10.w),
          Text(
            title,
            textScaleFactor: 1,
            style: TextStyle(
              letterSpacing: 0.2,
              fontWeight: FontWeight.w500,
              fontSize: 20.sp,
              color: greyColor,
            ),
          ),
          const Spacer(),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              hasSwitch ?? false
                  ? CustomSwitch(
                      isActive: isActive,
                      onSwitchMovie: onSwitchMovie,
                      onSwitchTV: onSwitchTV,
                    )
                  : Row(
                      mainAxisSize: MainAxisSize.min,
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
                        RotatedBox(
                          quarterTurns: 2,
                          child: Icon(
                            Icons.arrow_back_ios,
                            size: 10.sp,
                            color: greyColor,
                          ),
                        ),
                      ],
                    ),
            ],
          ),
        ],
      ),
    );
  }
}
