import 'dart:ui';

import 'package:flutter/material.dart';

class CustomNavigationBackground extends StatelessWidget {
  const CustomNavigationBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(25, 0, 25, 23),
      height: 60,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 2.0,
            sigmaY: 2.0,
          ),
          child: Container(),
        ),
      ),
    );
  }
}
