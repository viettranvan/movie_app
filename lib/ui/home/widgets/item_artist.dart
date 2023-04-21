import 'package:flutter/material.dart';
import 'package:movie_app/shared_ui/colors/colors.dart';

class ItemArtist extends StatelessWidget {
  final int itemCount;
  final int index;
  final VoidCallback? onTapItem;
  final VoidCallback? onTapViewAll;
  final String? title;
  final ImageProvider image;
  const ItemArtist({
    super.key,
    this.title,
    required this.image,
    required this.itemCount,
    required this.index,
    this.onTapItem,
    this.onTapViewAll,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: index == itemCount ? onTapViewAll : onTapItem,
      child: index == itemCount
          ? Column(
              children: [
                Container(
                  width: 67,
                  height: 100,
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(33.36),
                    boxShadow: [
                      BoxShadow(
                        color: lightGreyColor,
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                              color: darkBlueColor,
                              shape: BoxShape.circle,
                            ),
                          ),
                          Positioned.fill(
                            right: 10,
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: whiteColor,
                              textDirection: TextDirection.rtl,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'View all',
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        softWrap: true,
                        style: TextStyle(
                          fontSize: 12,
                          color: darkBlueColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          : Column(
              children: [
                Container(
                  width: 67,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(33.36),
                    boxShadow: [
                      BoxShadow(
                        color: lightGreyColor,
                        blurRadius: 5,
                      ),
                    ],
                    image: DecorationImage(
                      isAntiAlias: true,
                      filterQuality: FilterQuality.high,
                      fit: BoxFit.fill,
                      image: image,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                SizedBox(
                  width: 67,
                  child: Text(
                    title ?? '',
                    // 'Scarlett Johansson',
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    softWrap: true,
                    style: const TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}