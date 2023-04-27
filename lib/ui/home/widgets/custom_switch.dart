import 'package:flutter/material.dart';
import 'package:movie_app/shared_ui/colors/colors.dart';

class CustomSwitch extends StatelessWidget {
  final bool isActive;
  final VoidCallback? onSwitchMovie;
  final VoidCallback? onSwitchTV;
  const CustomSwitch({
    super.key,
    required this.isActive,
    this.onSwitchMovie,
    this.onSwitchTV,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 0, 17, 0),
      width: 100,
      height: 22,
      decoration: BoxDecoration(
        border: Border.all(
          color: darkBlueColor,
        ),
        borderRadius: BorderRadius.circular(50),
        color: whiteColor,
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          double widthSwitch = constraints.biggest.width;
          double widthTrack = widthSwitch / 2;
          return Stack(
            alignment: Alignment.center,
            children: [
              AnimatedAlign(
                duration: const Duration(milliseconds: 300),
                alignment: isActive ? Alignment.centerRight : Alignment.centerLeft,
                curve: Curves.decelerate,
                child: Container(
                  width: isActive ? widthTrack - 5 : widthTrack + 10,
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
                  GestureDetector(
                    onTap: onSwitchMovie,
                    child: Text(
                      'Movie',
                      style: TextStyle(
                        color: isActive ? blackColor : whiteColor,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: onSwitchTV,
                    child: Text(
                      'TV',
                      style: TextStyle(
                        color: isActive ? whiteColor : blackColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
