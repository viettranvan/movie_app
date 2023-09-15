import 'package:flutter/material.dart';
import 'package:movie_app/shared_ui/colors/color.dart';

class SliderIndicator extends StatelessWidget {
  final int length;
  final int indexIndicator;
  const SliderIndicator({
    super.key,
    required this.length,
    required this.indexIndicator,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: List.generate(
        length,
        (index) => AnimatedContainer(
          curve: Curves.linear,
          margin: const EdgeInsets.all(5),
          duration: const Duration(milliseconds: 200),
          height: 8,
          width: indexIndicator == index ? 30 : 8,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            border: Border.all(
              color: indexIndicator == index ? whiteColor : lightGreyColor,
            ),
            borderRadius: BorderRadius.circular(5),
            color: indexIndicator == index ? whiteColor : null,
          ),
        ),
      ),
    );
  }
}

//
