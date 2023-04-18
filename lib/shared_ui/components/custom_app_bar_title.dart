import 'package:flutter/material.dart';

class CustomAppBarTitle extends StatelessWidget {
  final String titleAppBar;
  const CustomAppBarTitle({
    super.key,
    required this.titleAppBar,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      titleAppBar,
      style: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
