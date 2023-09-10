import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/shared_ui/colors/color.dart';

class CustomNavigationBar extends StatelessWidget {
  final Widget background;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final int indexPage;
  final List<Widget> items;
  final double opacity;
  final bool visible;
  const CustomNavigationBar({
    super.key,
    required this.background,
    required this.margin,
    required this.padding,
    required this.indexPage,
    required this.items,
    required this.opacity,
    required this.visible,
  });
  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: opacity,
      duration: const Duration(milliseconds: 400),
      child: AnimatedAlign(
        duration: const Duration(milliseconds: 400),
        alignment: visible ? const Alignment(0, 1) : const Alignment(0, 1.4),
        child: Stack(
          children: [
            background,
            LayoutBuilder(
              builder: (context, constraints) {
                double widthNavigation =
                    constraints.biggest.width - (margin.horizontal + padding.horizontal);
                double widthCircle = widthNavigation / items.length;
                return Container(
                  height: 60.h,
                  margin: margin,
                  padding: padding,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.r),
                    gradient: LinearGradient(
                      colors: [
                        lightGreenColor.withOpacity(0.97),
                        lightBlueColor.withOpacity(0.97),
                      ],
                      stops: const [0, 1],
                    ),
                  ),
                  child: Stack(
                    fit: StackFit.passthrough,
                    alignment: Alignment.center,
                    children: [
                      AnimatedPositioned(
                        duration: const Duration(milliseconds: 150),
                        curve: Curves.decelerate,
                        left: widthCircle * indexPage,
                        top: 0,
                        bottom: 0,
                        width: widthCircle,
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: darkBlueColor.withOpacity(0.6),
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
        ),
      ),
    );
  }
}
