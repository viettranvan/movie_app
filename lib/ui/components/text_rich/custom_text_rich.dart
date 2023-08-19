import 'package:flutter/material.dart';

class CustomTextRich extends StatelessWidget {
  final String? primaryText;
  final String? secondaryText;
  final IconData icon;
  final Color? color;
  const CustomTextRich({
    super.key,
    this.primaryText,
    this.secondaryText,
    required this.icon,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Text.rich(
          TextSpan(
            children: [
              TextSpan(text: primaryText),
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Icon(
                    icon,
                    color: color,
                  ),
                ),
              ),
              TextSpan(text: secondaryText),
            ],
          ),
        ),
      ),
    );
  }
}
