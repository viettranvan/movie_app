import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/shared_ui/colors/color.dart';

class ItemViewAll extends StatelessWidget {
  final double? width;
  final double? height;
  const ItemViewAll({
    super.key,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: width,
          height: height,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: darkBlueColor,
            shape: BoxShape.circle,
          ),
          child: SizedBox(
            width: 13.w,
            child: Icon(
              Icons.arrow_back_ios,
              color: whiteColor,
              textDirection: TextDirection.rtl,
            ),
          ),
        ),
        SizedBox(height: 5.h),
        Text(
          'View all',
          textScaleFactor: 1,
          textAlign: TextAlign.center,
          softWrap: true,
          style: TextStyle(
            color: darkBlueColor,
            fontSize: 14.sp,
          ),
        ),
      ],
    );
  }
}
