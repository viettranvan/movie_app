import 'package:flutter/material.dart';

class CustomNavigationBarItem extends StatelessWidget {
  final VoidCallback? onTap;
  final String imagePath;
  const CustomNavigationBarItem({
    super.key,
    this.onTap,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: onTap,
        child: Image.asset(
          imagePath,
          scale: 2,
        ),
      ),
    );
  }
}
