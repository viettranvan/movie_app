import 'package:flutter/material.dart';
import 'package:movie_app/shared_ui/colors/colors.dart';
import 'package:movie_app/shared_ui/index.dart';

class AppTextField extends StatefulWidget {
  const AppTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.obscureText = false,
    this.hasSuffixIcon = false,
    this.textStyle,
    this.hintStyle,
    this.errorStyle,
    this.onChanged,
    this.onFieldSubmitted,
    this.keyboardType,
    this.textInputAction,
    this.errorText,
    this.errorMaxLines,
    this.enabled = true,
  }) : super(key: key);

  final TextEditingController controller;
  final bool obscureText;
  final bool hasSuffixIcon;
  final String hintText;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final TextStyle? errorStyle;
  final Function(String)? onChanged;
  final Function(String)? onFieldSubmitted;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final String? errorText;
  final int? errorMaxLines;
  final bool enabled;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late bool _obscureText;

  @override
  void initState() {
    setState(() {
      _obscureText = widget.obscureText;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: TextFormField(
        enabled: widget.enabled,
        controller: widget.controller,
        style: widget.textStyle ?? AppStyles.body02,
        keyboardType: widget.keyboardType,
        textInputAction: widget.textInputAction,
        obscureText: _obscureText,
        onChanged: widget.onChanged,
        onFieldSubmitted: widget.onFieldSubmitted,
        obscuringCharacter: '*',
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: widget.hintStyle,
          filled: true,
          fillColor: AppColors.textFieldBackground,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
            borderSide: BorderSide.none,
          ),
          errorText: widget.errorText,
          errorMaxLines: widget.errorMaxLines,
          errorStyle: widget.errorStyle ??
              AppStyles.body02.copyWith(color: AppColors.redPrimary),
          suffixIcon: widget.hasSuffixIcon ? _buildSuffix() : null,
        ),
      ),
    );
  }

  Widget _buildSuffix() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _obscureText = !_obscureText;
        });
      },
      child: Image.asset(
        _obscureText
            ? ImagesPath.eyeCloseIcon.assetName
            : ImagesPath.eyeOpenIcon.assetName,
        height: 38,
      ),
    );
  }
}
