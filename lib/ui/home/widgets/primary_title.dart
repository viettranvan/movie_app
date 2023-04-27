import 'package:flutter/material.dart';
import 'package:movie_app/shared_ui/colors/colors.dart';

class PrimaryTitle extends StatelessWidget {
  final String title;
  final bool? visibleIcon;
  final Widget? icon;
  final bool? visibleViewAll;
  final VoidCallback? onTapViewAll;
  const PrimaryTitle({
    super.key,
    this.visibleIcon,
    this.icon,
    this.visibleViewAll,
    this.onTapViewAll,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(17, 0, 10, 0),
          child: icon,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
          child: Text(
            title,
            style: TextStyle(
              letterSpacing: 0.2,
              fontWeight: FontWeight.w500,
              fontSize: 20,
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
