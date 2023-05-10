import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/shared_ui/colors/colors.dart';
import 'package:movie_app/shared_ui/index.dart';

enum ButtonStyles {
  elevated,
  disable,
}

class AppButton extends StatelessWidget {
  const AppButton({
    Key? key,
    this.width,
    this.height = 52,
    this.title,
    this.onPressed,
    this.buttonStyle = ButtonStyles.elevated,
  }) : super(key: key);

  final double? width;
  final double? height;
  final String? title;
  final VoidCallback? onPressed;
  final ButtonStyles buttonStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: ShapeDecoration(
        shape: const StadiumBorder(),
        color: _getColor(context, buttonStyle),
      ),
      child: CupertinoButton(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        onPressed: onPressed,
        child: Text(
          title ?? '',
          style: 
          
          AppStyles.body02.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      ),
    );
  }

  Color? _getColor(BuildContext context, ButtonStyles buttonStyle) {
    switch (buttonStyle) {
      case ButtonStyles.elevated:
        return Theme.of(context).colorScheme.primary;
      case ButtonStyles.disable:
        return Theme.of(context).colorScheme.secondaryContainer;
    }
  }
}
