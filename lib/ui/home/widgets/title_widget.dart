// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:movie_app/shared_ui/colors/colors.dart';

class TitleWidget extends StatelessWidget {
  final Color? colorTitle;
  final String textTitle;
  const TitleWidget({
    super.key,
    this.colorTitle,
    required this.textTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
      child: Text(
        textTitle,
        style: TextStyle(
          fontSize: 20,
          foreground: Paint()
            ..shader = LinearGradient(
              colors: [
                paleGreenColor,
                skyBlueColor,
              ],
            ).createShader(
              const Rect.fromLTWH(
                0.0,
                0.0,
                200.0,
                70.0,
              ),
            ),
        ),
      ),
    );
  }
}
