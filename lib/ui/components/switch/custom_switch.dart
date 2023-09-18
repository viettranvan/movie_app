import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/shared_ui/colors/color.dart';

class CustomSwitch extends StatelessWidget {
  final bool? isActive;
  final VoidCallback? onSwitchMovie;
  final VoidCallback? onSwitchTV;
  const CustomSwitch({
    super.key,
    this.isActive,
    this.onSwitchMovie,
    this.onSwitchTV,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 150.w,
      height: 22.h,
      decoration: BoxDecoration(
        border: Border.all(
          color: darkBlueColor,
        ),
        borderRadius: BorderRadius.circular(50.r),
        color: whiteColor,
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          double widthSwitch = constraints.maxWidth;
          double widthTrack = widthSwitch / 2;
          return Stack(
            alignment: Alignment.center,
            children: [
              AnimatedAlign(
                duration: const Duration(milliseconds: 300),
                alignment: isActive ?? false ? Alignment.centerRight : Alignment.centerLeft,
                curve: Curves.decelerate,
                child: Container(
                  width: isActive ?? false ? widthTrack : widthTrack,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(50.r),
                    color: darkBlueColor,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: onSwitchMovie,
                      child: Text(
                        'Movies',
                        textScaleFactor: 1,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: isActive ?? false ? blackColor : whiteColor,
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: onSwitchTV,
                      child: Text(
                        'TV Shows',
                        textScaleFactor: 1,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: isActive ?? false ? whiteColor : blackColor,
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
