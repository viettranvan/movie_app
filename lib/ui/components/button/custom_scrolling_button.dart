import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/shared_ui/shared_ui.dart';

class CustomScrollButton extends StatelessWidget {
  final bool visible;
  final double opacity;
  final VoidCallback? onTap;
  const CustomScrollButton({
    super.key,
    required this.opacity,
    this.onTap,
    required this.visible,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedOpacity(
        opacity: opacity,
        duration: const Duration(milliseconds: 200),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 200),
          alignment: visible ? const Alignment(0, -0.9) : const Alignment(0, -1.3),
          child: Container(
            padding: const EdgeInsets.all(10).w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: whiteColor,
              boxShadow: [
                BoxShadow(
                  color: greyColor,
                  blurRadius: 2,
                ),
              ],
            ),
            child: Icon(
              Icons.arrow_upward,
              color: darkBlueColor,
              size: 20.sp,
            ),
          ),
        ),
      ),
    );
  }
}
