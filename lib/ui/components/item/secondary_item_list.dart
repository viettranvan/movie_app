import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:movie_app/shared_ui/colors/colors.dart';
import 'package:movie_app/ui/components/components.dart';

class SecondaryItemList extends StatelessWidget {
  final int itemCount;
  final int index;
  final VoidCallback? onTapItem;
  final VoidCallback? onTapViewAll;
  final String? title;
  final String imageUrl;
  const SecondaryItemList({
    super.key,
    this.title,
    required this.imageUrl,
    required this.itemCount,
    required this.index,
    this.onTapItem,
    this.onTapViewAll,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: index == itemCount ? onTapViewAll : onTapItem,
      child: RepaintBoundary(
        child: Column(
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
              child: index == itemCount
                  ? ItemViewAll(
                      width: 35,
                      height: 35,
                      style: TextStyle(
                        color: darkBlueColor,
                        fontSize: 12,
                      ),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(33.36),
                      child: CachedNetworkImage(
                        imageUrl: imageUrl,
                        width: double.infinity,
                        height: double.infinity,
                        filterQuality: FilterQuality.high,
                        fit: BoxFit.fill,
                        progressIndicatorBuilder: (context, url, progress) => Center(
                          child: Center(
                            child: CupertinoActivityIndicator(
                              color: darkBlueColor,
                            ),
                          ),
                        ),
                        errorWidget: (context, url, error) => Center(
                          child: CupertinoActivityIndicator(
                            color: darkBlueColor,
                          ),
                        ),
                      ),
                    ),
            ),
            const SizedBox(height: 7),
            SizedBox(
              width: 67,
              child: Text(
                title ?? '',
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
      ),
    );
  }
}
