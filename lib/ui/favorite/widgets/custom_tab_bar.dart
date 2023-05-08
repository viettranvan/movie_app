import 'package:flutter/material.dart';
import 'package:movie_app/shared_ui/colors/colors.dart';

class CustomTabBar extends StatelessWidget {
  final VoidCallback? onTapMovie;
  final VoidCallback? onTapTv;
  final int index;
  final double? widthTabBar;
  const CustomTabBar({
    super.key,
    this.onTapMovie,
    this.onTapTv,
    required this.index,
    this.widthTabBar,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double paddingRight = const EdgeInsets.all(15).right;
        double paddingLeft = const EdgeInsets.all(15).left;
        double width = (constraints.biggest.width - (paddingLeft + paddingRight)) / 2;
        return Padding(
          padding: EdgeInsets.fromLTRB(paddingLeft, 15, paddingRight, 15),
          child: Stack(
            children: [
              Positioned.fill(
                child: AnimatedAlign(
                  duration: const Duration(milliseconds: 250),
                  alignment: index == 0 ? Alignment.centerLeft : Alignment.centerRight,
                  curve: Curves.decelerate,
                  child: Container(
                    width: width,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(50),
                      color: darkBlueColor,
                    ),
                  ),
                ),
              ),
              Container(
                width: widthTabBar,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(
                    color: darkBlueColor,
                    width: 2,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: onTapMovie,
                        child: Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              bottomLeft: Radius.circular(20),
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'Movies',
                            style: TextStyle(
                              fontSize: 15,
                              color: index == 0 ? whiteColor : darkBlueColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: onTapTv,
                        child: Container(
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                            ),
                          ),
                          child: Text(
                            'Tv Shows',
                            style: TextStyle(
                              fontSize: 15,
                              color: index == 1 ? whiteColor : darkBlueColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
