import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/shared_ui/colors/color.dart';

class CustomTabBar extends StatelessWidget {
  final VoidCallback? onTapMovie;
  final VoidCallback? onTapTv;
  final int index;
  final double? widthTabBar;
  const CustomTabBar({
    super.key,
    this.onTapMovie,
    this.onTapTv,
    required this.index,
    this.widthTabBar,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double paddingRight = const EdgeInsets.all(15).right;
        double paddingLeft = const EdgeInsets.all(15).left;
        double width = (constraints.biggest.width - (paddingLeft + paddingRight)) / 2.w;
        return Padding(
          padding: EdgeInsets.fromLTRB(paddingLeft.w, 15.h, paddingRight, 15.h),
          child: Stack(
            children: [
              Positioned.fill(
                child: AnimatedAlign(
                  duration: const Duration(milliseconds: 250),
                  alignment: index == 0 ? Alignment.centerLeft : Alignment.centerRight,
                  curve: Curves.decelerate,
                  child: Container(
                    width: width,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(50.r),
                      color: darkBlueColor,
                    ),
                  ),
                ),
              ),
              Container(
                width: widthTabBar,
                height: 40.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22.r),
                  border: Border.all(
                    color: darkBlueColor,
                    width: 2.w,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: onTapMovie,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20.r),
                              bottomLeft: Radius.circular(20.r),
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'Movies',
                            textScaleFactor: 1.1,
                            style: TextStyle(
                              fontSize: 15.sp,
                              color: index == 0 ? whiteColor : darkBlueColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: onTapTv,
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20.r),
                              bottomRight: Radius.circular(20.r),
                            ),
                          ),
                          child: Text(
                            'Tv Shows',
                            textScaleFactor: 1.1,
                            style: TextStyle(
                              fontSize: 15.sp,
                              color: index == 1 ? whiteColor : darkBlueColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
