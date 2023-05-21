import 'package:flutter/material.dart';
import 'package:movie_app/shared_ui/colors/colors.dart';
import 'package:movie_app/utils/app_utils/app_utils.dart';

class CustomDropDown extends StatelessWidget {
  final Widget Function(BuildContext, int) itemBuilder;
  final VoidCallback? onTapDropDown;
  final bool isDropDown;
  final String itemSelected;
  final List<String> items;
  final IconData? icon;
  const CustomDropDown({
    super.key,
    this.onTapDropDown,
    required this.isDropDown,
    required this.itemSelected,
    required this.items,
    required this.itemBuilder,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    double heightDropDown = 28;
    return GestureDetector(
      child: Stack(
        children: [
          Positioned(
            child: AnimatedContainer(
              height: isDropDown ? heightDropDown * (items.length + 1) + 35 : heightDropDown,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.symmetric(horizontal: 5),
              alignment: AlignmentDirectional.center,
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: darkBlueColor,
                  width: 1,
                ),
              ),
              duration: const Duration(milliseconds: 500),
              curve: Curves.fastOutSlowIn,
              child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(0, 36, 0, 5),
                itemBuilder: itemBuilder,
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: separatorBuilder,
                itemCount: items.length,
              ),
            ),
          ),
          GestureDetector(
            onTap: onTapDropDown,
            child: Container(
              height: 30,
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: darkBlueColor,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: darkBlueColor,
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox.shrink(),
                  Padding(
                    padding: const EdgeInsets.only(left: 25),
                    child: Text(
                      AppUtils().getSortTitle(itemSelected),
                      style: TextStyle(
                        color: whiteColor,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Icon(
                    icon,
                    color: whiteColor,
                    opticalSize: 10,
                    weight: 30,
                    fill: 1,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget separatorBuilder(BuildContext context, int index) => const SizedBox();
}
