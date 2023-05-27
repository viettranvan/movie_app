import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie_app/shared_ui/shared_ui.dart';

class CustomTextField extends StatelessWidget {
  final String? hintText;
  final bool? visibleFiler;
  final bool? obscureText;
  final bool? isAuthentication;
  final void Function(String)? onChanged;
  final VoidCallback? onTapSuffixIcon;
  final VoidCallback? onTapFilter;

  const CustomTextField({
    super.key,
    this.onTapSuffixIcon,
    this.visibleFiler,
    this.obscureText,
    this.onChanged,
    this.isAuthentication,
    this.hintText,
    this.onTapFilter,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: TextFormField(
              cursorColor: darkBlueColor,
              obscureText: obscureText ?? false,
              onChanged: onChanged,
              decoration: InputDecoration(
                filled: true,
                fillColor: whiteColor,
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                hintText: hintText,
                hintStyle: TextStyle(
                  color: greyColor,
                ),
                prefixIcon: (isAuthentication ?? false)
                    ? null
                    : IconButton(
                        onPressed: null,
                        icon: SvgPicture.asset(
                          ImagesPath.searchIcon.assetName,
                          fit: BoxFit.scaleDown,
                          width: 20,
                          height: 20,
                          colorFilter: ColorFilter.mode(
                            darkBlueColor,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                suffixIcon: (isAuthentication ?? false)
                    ? IconButton(
                        onPressed: onTapSuffixIcon,
                        icon: Image.asset(
                          (obscureText ?? false)
                              ? ImagesPath.eyeCloseIcon.assetName
                              : ImagesPath.eyeOpenIcon.assetName,
                          fit: BoxFit.scaleDown,
                          color: darkBlueColor,
                          scale: 1.2,
                        ),
                      )
                    : null,
                focusedBorder: outlineInputBorder,
                enabledBorder: outlineInputBorder,
              ),
            ),
          ),
          const SizedBox(width: 4),
          Visibility(
            visible: visibleFiler ?? true,
            child: GestureDetector(
              onTap: onTapFilter,
              child: Container(
                padding: const EdgeInsets.all(13),
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
                  ImagesPath.filterIcon.assetName,
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
