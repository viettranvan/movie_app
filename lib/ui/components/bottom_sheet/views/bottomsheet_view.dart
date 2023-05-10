import 'package:flutter/material.dart';
import 'package:movie_app/shared_ui/colors/colors.dart';

class BottomSheetView extends StatelessWidget {
  const BottomSheetView({Key? key, this.child}) : super(key: key);

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 24,
            child: Center(
              child: Container(
                height: 4,
                width: 55,
                decoration: const BoxDecoration(
                  color: AppColors.darkSurface,
                  borderRadius: BorderRadius.all(
                    Radius.circular(2.0),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: child,
            ),
          )
        ],
      ),
    );
  }
}
