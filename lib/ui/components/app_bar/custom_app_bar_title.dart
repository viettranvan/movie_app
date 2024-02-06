import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppBarTitle extends StatelessWidget {
  final String titleAppBar;
  const CustomAppBarTitle({
    super.key,
    required this.titleAppBar,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      titleAppBar,
      textScaleFactor: 1,
      maxLines: 2,
      style: TextStyle(
        fontSize: 22.sp,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
