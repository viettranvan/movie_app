import 'package:flutter/material.dart';
import 'package:movie_app/shared_ui/index.dart';

class Background extends StatelessWidget {
  const Background({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      ImagesPath.background.assetName,
      height: 200,
      filterQuality: FilterQuality.high,
      fit: BoxFit.cover,
    );
  }
}
