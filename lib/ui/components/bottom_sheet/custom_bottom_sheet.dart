import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/shared_ui/shared_ui.dart';

class CustomBottomSheet extends StatelessWidget {
  final String? title;
  final String? titleConfirm;
  final String? titleCancel;
  final VoidCallback onPressConfirm;
  final VoidCallback onPressCancel;

  const CustomBottomSheet({
    super.key,
    this.title,
    this.titleConfirm,
    this.titleCancel,
    required this.onPressConfirm,
    required this.onPressCancel,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoActionSheet(
      title: Text(
        title ?? '',
        style: TextStyle(
          fontSize: 14.sp,
        ),
      ),
      actions: [
        CupertinoActionSheetAction(
          isDefaultAction: false,
          onPressed: onPressConfirm,
          child: Text(
            titleConfirm ?? '',
            style: TextStyle(
              color: Colors.red,
              fontSize: 18.sp,
            ),
          ),
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        isDefaultAction: true,
        onPressed: onPressCancel,
        child: Text(
          titleCancel ?? '',
          style: TextStyle(
            color: blackColor,
            fontSize: 18.sp,
          ),
        ),
      ),
    );
  }
}