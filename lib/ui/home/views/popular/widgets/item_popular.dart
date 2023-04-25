import 'package:flutter/material.dart';

class ItemPopular extends StatelessWidget {
  final VoidCallback? onTap;
  final String urlImage;
  const ItemPopular({
    super.key,
    this.onTap,
    required this.urlImage,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
    
      child: SizedBox(
        child: Image.network(
          urlImage,
          width: double.infinity,
          filterQuality: FilterQuality.high,
          fit: BoxFit.fitWidth,
        ),
      ),
    );
  }
}
