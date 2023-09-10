import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/shared_ui/colors/color.dart';
import 'package:movie_app/utils/app_utils/app_utils.dart';

class CustomDropDown extends StatelessWidget {
  final Widget Function(BuildContext, int) itemBuilder;
  final VoidCallback? onTapDropDown;
  final bool isDropDown;
  final String itemSelected;
  final List<String> items;
  final IconData? icon;
  const CustomDropDown({
    super.key,
    this.onTapDropDown,
    required this.isDropDown,
    required this.itemSelected,
    required this.items,
    required this.itemBuilder,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Stack(
        children: [
          Positioned(
            child: AnimatedContainer(
              height: isDropDown ? (28.h * (items.length + 1) + 35).w : 28,
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              alignment: AlignmentDirectional.center,
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(
                  color: darkBlueColor,
                  width: 1.w,
                ),
              ),
              duration: const Duration(milliseconds: 500),
              curve: Curves.fastOutSlowIn,
              child: ListView.separated(
                padding: EdgeInsets.fromLTRB(0, 36.h, 0, 5.h),
                itemBuilder: itemBuilder,
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: separatorBuilder,
                itemCount: items.length,
              ),
            ),
          ),
          GestureDetector(
            onTap: onTapDropDown,
            child: Container(
              height: 30.h,
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              decoration: BoxDecoration(
                color: darkBlueColor,
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(
                  color: darkBlueColor,
                  width: 1.w,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox.shrink(),
                  Padding(
                    padding: EdgeInsets.only(left: 25.w),
                    child: Text(
                      AppUtils().getSortTitle(itemSelected),
                      textScaleFactor: 1,
                      style: TextStyle(
                        color: whiteColor,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                  Icon(
                    icon,
                    color: whiteColor,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget separatorBuilder(BuildContext context, int index) => const SizedBox();
}
