import 'package:flutter/material.dart';
import 'package:movie_app/shared_ui/colors/colors.dart';

class TitleWidget extends StatelessWidget {
  final Color? colorTitle;
  final String textTitle;
  final double? sizeTitle;
  const TitleWidget({
    super.key,
    this.colorTitle,
    required this.textTitle,
    this.sizeTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Text(
        textTitle,
        style: TextStyle(
          letterSpacing: 0.2,
          fontWeight: FontWeight.w500,
          fontSize: sizeTitle,
          color: greyColor,
        ),
      ),
    );
  }
}
