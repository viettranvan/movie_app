import 'package:flutter/material.dart';
import 'package:movie_app/shared_ui/colors/colors.dart';

class CustomNavigationBar extends StatelessWidget {
  final Widget background;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final int lengthPages;
  final int indexPage;
  final List<Widget> items;
  const CustomNavigationBar({
    super.key,
    required this.background,
    required this.margin,
    required this.padding,
    required this.lengthPages,
    required this.indexPage,
    required this.items,
  });
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        background,
        LayoutBuilder(
          builder: (context, constraints) {
            double widthNavigation =
                constraints.biggest.width - (margin.horizontal + padding.horizontal);
            double widthCircle = widthNavigation / lengthPages;
            double left = widthCircle * indexPage;
            return Container(
              height: 60,
              margin: margin,
              padding: padding,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                gradient: LinearGradient(
                  colors: [
                    lightGreenColor.withOpacity(0.97),
                    lightBlueColor.withOpacity(0.97),
                  ],
                  stops: const [0, 1],
                ),
              ),
              child: Stack(
                children: [
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 150),
                    curve: Curves.decelerate,
                    left: left,
                    top: 0,
                    bottom: 0,
                    width: widthCircle,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: darkGreenColor.withOpacity(0.6),
                      ),
                    ),
                  ),
                  Row(
                    children: items,
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
