import 'package:flutter/material.dart';
import 'package:movie_app/shared_ui/colors/colors.dart';

class ItemUpcoming extends StatelessWidget {
  final ImageProvider image;
  final VoidCallback? onTap;
  const ItemUpcoming({
    super.key,
    required this.image,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.fromLTRB(2.5, 0, 2.5, 0),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
              color: lightGreyColor,
              blurRadius: 5,
            ),
          ],
          image: DecorationImage(
            image: image,
            filterQuality: FilterQuality.high,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
