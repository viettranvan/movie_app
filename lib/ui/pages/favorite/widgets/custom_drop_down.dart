import 'package:flutter/material.dart';
import 'package:movie_app/shared_ui/colors/colors.dart';

class CustomDropDown extends StatelessWidget {
  final Widget Function(BuildContext, int) itemBuilder;
  final VoidCallback? onTapDropDown;
  final bool isDropDown;
  final String? itemSelected;
  final List<String> items;
  final int indexSelected;
  const CustomDropDown({
    super.key,
    this.onTapDropDown,
    required this.isDropDown,
    this.itemSelected,
    required this.items,
    required this.itemBuilder,
    required this.indexSelected,
  });

  @override
  Widget build(BuildContext context) {
    double heightDropDown = 30;
    return GestureDetector(
      child: Stack(
        children: [
          Positioned(
            child: AnimatedContainer(
              height: isDropDown ? heightDropDown * (items.length + 1) + 35 : heightDropDown,
              margin: const EdgeInsets.symmetric(horizontal: 25),
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
                shrinkWrap: true,
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 5),
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
              margin: const EdgeInsets.symmetric(horizontal: 25),
              decoration: BoxDecoration(
                color: darkBlueColor,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: darkBlueColor,
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      indexSelected >= 0 ? (itemSelected ?? '') : 'Sort',
                      style: TextStyle(
                        color: whiteColor,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.arrow_drop_down,
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
