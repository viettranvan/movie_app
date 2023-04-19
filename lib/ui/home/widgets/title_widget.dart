import 'package:flutter/material.dart';
import 'package:movie_app/shared_ui/colors/colors.dart';

class TitleWidget extends StatelessWidget {
  final String textTitle;
  final double? sizeTitle;
  final double paddingLeft;
  final bool? visibleIcon;
  final Widget? icon;
  final bool? visibleViewAll;
  final VoidCallback? onTapViewAll;
  const TitleWidget({
    super.key,
    this.sizeTitle,
    this.visibleIcon,
    this.icon,
    this.visibleViewAll,
    this.onTapViewAll,
    required this.paddingLeft,
    required this.textTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Visibility(
          visible: visibleIcon ?? false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(17, 0, 10, 0),
            child: icon,
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(paddingLeft, 0, 20, 0),
          child: Text(
            textTitle,
            style: TextStyle(
              letterSpacing: 0.2,
              fontWeight: FontWeight.w500,
              fontSize: sizeTitle,
              color: greyColor,
            ),
          ),
        ),
        const Spacer(),
        Visibility(
          visible: visibleViewAll ?? false,
          child: Row(
            children: [
              GestureDetector(
                onTap: onTapViewAll,
                child: Text(
                  'View all',
                  style: TextStyle(
                    letterSpacing: 0.2,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: greyColor,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 17, 0),
                child: RotatedBox(
                  quarterTurns: 2,
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: 10,
                    color: greyColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
