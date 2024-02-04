import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/shared_ui/colors/color.dart';

class PrimaryItem extends StatelessWidget {
  final VoidCallback? onTap;
  final String? title;
  final List<Color>? colors;
  final List<double>? stops;
  const PrimaryItem({
    super.key,
    this.onTap,
    required this.title,
    this.colors,
    this.stops,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8).w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
          gradient: LinearGradient(
            colors: colors ?? [lightGreyColor],
            stops: stops ?? [0],
          ),
        ),
        child: Text(
          title ?? '',
          textScaleFactor: 1,
          style: TextStyle(
            fontSize: 14.sp,
            color: whiteColor,
          ),
        ),
      ),
    );
  }
}
