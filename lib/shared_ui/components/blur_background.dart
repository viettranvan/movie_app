import 'dart:ui';

import 'package:flutter/material.dart';

class BlurBackground extends StatelessWidget {
  final double? heightBackground;
  final double? radiusCorner;
  final double? paddingHorizontal;
  final double? width;
  const BlurBackground({
    super.key,
    this.heightBackground,
    this.radiusCorner,
    this.paddingHorizontal,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: paddingHorizontal ?? 0),
      height: heightBackground,
      width: width,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radiusCorner ?? 0),
        child: BackdropFilter(
          blendMode: BlendMode.srcOver,
          filter: ImageFilter.blur(
            sigmaX: 5.0,
            sigmaY: 5.0,
          ),
          child: const SizedBox.expand(),
        ),
      ),
    );
  }
}
