import 'package:flutter/material.dart';
import 'package:movie_app/shared_ui/colors/colors.dart';

class Indicator extends StatelessWidget {
  final bool isActive;
  const Indicator({
    super.key,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      curve: Curves.linear,
      margin: const EdgeInsets.all(5),
      duration: const Duration(milliseconds: 350),
      height: 8,
      width: isActive ? 30 : 8,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        border: Border.all(
          color: isActive ? whiteColor : lightGreyColor,
        ),
        borderRadius: BorderRadius.circular(5),
        color: isActive ? whiteColor : null,
      ),
    );
  }
}

//
