import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/shared_ui/colors/color.dart';

class CustomSwitch extends StatelessWidget {
  final bool isActive;
  final VoidCallback? onSwitchMovie;
  final VoidCallback? onSwitchTV;
  const CustomSwitch({
    super.key,
    required this.isActive,
    this.onSwitchMovie,
    this.onSwitchTV,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 0, 17.w, 0),
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
          double widthSwitch = constraints.biggest.width.w;
          double widthTrack = widthSwitch / 2;
          return Stack(
            alignment: Alignment.center,
            children: [
              AnimatedAlign(
                duration: const Duration(milliseconds: 300),
                alignment: isActive ? Alignment.centerRight : Alignment.centerLeft,
                curve: Curves.decelerate,
                child: Container(
                  width: isActive ? widthTrack.w + 10.w : widthTrack.w - 8.w,
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
                children: [
                  GestureDetector(
                    onTap: onSwitchMovie,
                    child: Text(
                      'Movies',
                      textScaleFactor: 1,
                      style: TextStyle(
                        color: isActive ? blackColor : whiteColor,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: onSwitchTV,
                    child: Text(
                      'TV Shows',
                      textScaleFactor: 1,
                      style: TextStyle(
                        color: isActive ? whiteColor : blackColor,
                        fontSize: 14.sp,
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
