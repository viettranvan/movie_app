import 'package:flutter/material.dart';
import 'package:movie_app/shared_ui/colors/colors.dart';

class CustomSwitch extends StatelessWidget {
  final bool isActive;
  final VoidCallback? onSwitch;
  const CustomSwitch({
    super.key,
    required this.isActive,
    this.onSwitch,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSwitch,
      child: Container(
        margin: const EdgeInsets.fromLTRB(0, 0, 17, 0),
        width: 90,
        height: 23,
        decoration: BoxDecoration(
          border: Border.all(
            color: darkBlueColor,
          ),
          borderRadius: BorderRadius.circular(50),
          color: Colors.white,
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            double widthSwitch = constraints.biggest.width;
            double widthTracking = widthSwitch / 2;
            return Stack(
              alignment: Alignment.center,
              children: [
                AnimatedAlign(
                  duration: const Duration(milliseconds: 300),
                  alignment: isActive ? Alignment.centerRight : Alignment.centerLeft,
                  curve: Curves.decelerate,
                  child: Container(
                    width: isActive ? widthTracking - 5 : widthTracking + 10,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(50),
                      color: darkBlueColor,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'Movie',
                      style: TextStyle(
                        color: isActive ? blackColor : whiteColor,
                      ),
                    ),
                    // SizedBox.shrink(),
                    Text(
                      'TV',
                      style: TextStyle(
                        color: isActive ? whiteColor : blackColor,
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
