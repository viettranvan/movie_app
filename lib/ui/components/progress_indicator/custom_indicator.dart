import 'package:flutter/cupertino.dart';
import 'package:movie_app/shared_ui/colors/color.dart';

class CustomIndicator extends StatelessWidget {
  final double? radius;
  const CustomIndicator({
    super.key,
    this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoActivityIndicator(
      color: darkBlueColor,
      radius: radius ?? 10,
    );
  }
}
