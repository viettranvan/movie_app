import 'package:flutter/material.dart';
import 'package:movie_app/utils/app_utils/app_utils.dart';

class CustomDropDownItem extends StatelessWidget {
  final VoidCallback? onTapItem;
  final Color? colorSelected;
  final String title;
  final Color? colorTitle;
  const CustomDropDownItem({
    super.key,
    this.onTapItem,
    this.colorSelected,
    required this.title,
    this.colorTitle,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapItem,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: colorSelected,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          AppUtils().getSortTitle(title),
          style: TextStyle(
            color: colorTitle,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

 
}
