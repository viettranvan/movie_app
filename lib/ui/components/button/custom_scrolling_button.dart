import 'package:flutter/material.dart';
import 'package:movie_app/shared_ui/shared_ui.dart';

class CustomScrollingButton extends StatelessWidget {
  final AlignmentGeometry alignment;
  final double opacity;
  final VoidCallback? onTap;
  const CustomScrollingButton({
    super.key,
    required this.alignment,
    required this.opacity,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedAlign(
      alignment: alignment,
      duration: const Duration(milliseconds: 500),
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 500),
        opacity: opacity,
        child: GestureDetector(
          onTap: onTap,
          child: Container(
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
            child: RotatedBox(
              quarterTurns: 45,
              child: Icon(
                Icons.arrow_circle_left_rounded,
                color: darkBlueColor,
                size: 50,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
