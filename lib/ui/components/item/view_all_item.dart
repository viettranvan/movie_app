import 'package:flutter/material.dart';
import 'package:movie_app/shared_ui/colors/color.dart';

class ItemViewAll extends StatelessWidget {
  final double? width;
  final double? height;
  final TextStyle? style;
  const ItemViewAll({
    super.key,
    this.width,
    this.height,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          children: [
            Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                color: darkBlueColor,
                shape: BoxShape.circle,
              ),
            ),
            Positioned.fill(
              right: 10,
              child: Icon(
                Icons.arrow_back_ios,
                color: whiteColor,
                textDirection: TextDirection.rtl,
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Text(
          'View all',
          textAlign: TextAlign.center,
          softWrap: true,
          style: style,
        ),
      ],
    );
  }
}
