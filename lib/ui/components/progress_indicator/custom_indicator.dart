import 'package:flutter/cupertino.dart';
import 'package:movie_app/shared_ui/colors/color.dart';

class CustomIndicator extends StatelessWidget {
  const CustomIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoActivityIndicator(
      color: darkBlueColor,
      radius: 10,
    );
  }
}
