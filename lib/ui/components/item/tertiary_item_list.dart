import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:movie_app/shared_ui/colors/colors.dart';
import 'package:movie_app/ui/components/components.dart';

class TertiaryItemList extends StatelessWidget {
  final int itemCount;
  final int index;
  final VoidCallback? onTapItem;
  final VoidCallback? onTapViewAll;
  final String imageUrl;
  final String? title;
  const TertiaryItemList({
    super.key,
    required this.itemCount,
    required this.index,
    this.onTapItem,
    this.onTapViewAll,
    required this.imageUrl,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: index == itemCount ? onTapViewAll : onTapItem,
      child: RepaintBoundary(
        child: Container(
          width: 120,
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: lightGreyColor,
                blurRadius: 5,
              ),
            ],
          ),
          child: index == itemCount
              ? ItemViewAll(
                  width: 50,
                  height: 50,
                  style: TextStyle(
                    color: darkBlueColor,
                  ),
                )
              : Column(
                  children: [
                    SizedBox(
                      height: 171,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                        ),
                        child: CachedNetworkImage(
                          imageUrl: imageUrl,
                          filterQuality: FilterQuality.high,
                          width: double.infinity,
                          fit: BoxFit.fill,
                          progressIndicatorBuilder: (context, url, progress) =>
                              const CustomIndicator(),
                          errorWidget: (context, url, error) => const CustomIndicator(),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(7),
                      child: Text(
                        title ?? '',
                        maxLines: 1,
                        softWrap: false,
                        style: const TextStyle(
                          fontSize: 14.5,
                          overflow: TextOverflow.clip,
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
