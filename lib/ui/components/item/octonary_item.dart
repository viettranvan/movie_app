import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/shared_ui/shared_ui.dart';

class OctonaryItem extends StatelessWidget {
  final VoidCallback? onTapItem;
  final String? title;
  final List<Color>? colors;
  final List<double>? stops;
  const OctonaryItem({
    super.key,
    this.onTapItem,
    required this.title,
    this.colors,
    this.stops,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapItem,
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
