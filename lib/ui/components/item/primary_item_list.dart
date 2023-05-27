import 'package:flutter/material.dart';
import 'package:movie_app/shared_ui/colors/colors.dart';

class PrimaryItemList extends StatelessWidget {
  final VoidCallback? onTap;
  final String? title;
  final List<Color>? colors;
  final List<double>? stops;
  const PrimaryItemList({
    super.key,
    this.onTap,
    required this.title,
    this.colors,
    this.stops,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          gradient: LinearGradient(
            colors: colors ?? [lightGreyColor],
            stops: stops ?? [0],
          ),
        ),
        child: Text(
          title ?? '',
          style: TextStyle(
            color: whiteColor,
          ),
        ),
      ),
    );
  }
}
