import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie_app/shared_ui/shared_ui.dart';

class CustomTextField extends StatelessWidget {
  final String? hintText;
  final bool? visibleFiler;
  final bool? obscureText;
  final bool? isAuthentication;
  final void Function(String)? onChanged;
  final VoidCallback? onTapFilter;
  final TextEditingController? controller;
  final Widget? suffixIcon;
  const CustomTextField({
    super.key,
    this.visibleFiler,
    this.obscureText,
    this.onChanged,
    this.isAuthentication,
    this.hintText,
    this.onTapFilter,
    this.controller,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 20.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: MediaQuery(
              data: MediaQuery.of(context).copyWith(
                textScaleFactor: 1,
              ),
              child: TextFormField(
                controller: controller,
                cursorColor: darkBlueColor,
                obscureText: obscureText ?? false,
                onChanged: onChanged,
                onTapOutside: (event) => FocusScope.of(context).requestFocus(FocusNode()),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: whiteColor,
                  contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
                  hintText: hintText,
                  hintStyle: TextStyle(
                    color: greyColor,
                    fontSize: 15.sp,
                  ),
                  prefixIcon: (isAuthentication ?? false)
                      ? null
                      : IconButton(
                          onPressed: null,
                          icon: SvgPicture.asset(
                            IconsPath.searchIcon.assetName,
                            fit: BoxFit.scaleDown,
                            width: 20.w,
                            height: 20.h,
                            colorFilter: ColorFilter.mode(
                              darkBlueColor,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                  suffixIcon: suffixIcon,
                  focusedBorder: outlineInputBorder,
                  enabledBorder: outlineInputBorder,
                ),
              ),
            ),
          ),
          SizedBox(width: 4.w),
          Visibility(
            visible: visibleFiler ?? true,
            child: GestureDetector(
              onTap: onTapFilter,
              child: Container(
                padding: const EdgeInsets.all(13).dg,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: whiteColor,
                  boxShadow: [
                    BoxShadow(
                      color: greyColor,
                      blurRadius: 1,
                    ),
                  ],
                ),
                child: SvgPicture.asset(
                  IconsPath.filterIcon.assetName,
                  colorFilter: ColorFilter.mode(
                    darkBlueColor,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
