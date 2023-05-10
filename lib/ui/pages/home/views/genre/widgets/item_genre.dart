import 'package:flutter/material.dart';
import 'package:movie_app/shared_ui/colors/colors.dart';

class ItemGenre extends StatelessWidget {
  final VoidCallback? onTap;
  final String? genreName;
  const ItemGenre({
    super.key,
    this.onTap,
    required this.genreName,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: lightGreyColor,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(
          genreName??'',
          style: TextStyle(
            color: whiteColor,
          ),
        ),
      ),
    );
  }
}
