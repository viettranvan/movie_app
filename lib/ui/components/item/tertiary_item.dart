import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/shared_ui/shared_ui.dart';
import 'package:movie_app/ui/components/components.dart';

class TertiaryItem extends StatelessWidget {
  final int itemCount;
  final int index;
  final VoidCallback? onTapItem;
  final VoidCallback? onTapViewAll;
  final String imageUrl;
  final String? title;
  const TertiaryItem({
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
      onTap: index >= itemCount ? onTapViewAll : onTapItem,
      child: RepaintBoundary(
        child: Container(
          width: 120.w,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(15.r),
            boxShadow: [
              BoxShadow(
                color: lightGreyColor,
                blurRadius: 5,
              ),
            ],
          ),
          child: index >= itemCount
              ? ItemViewAll(
                  width: 50.w,
                  height: 50.h,
                )
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CachedNetworkImage(
                      imageUrl: imageUrl,
                      filterQuality: FilterQuality.high,
                      width: double.infinity,
                      height: 171.h,
                      fit: BoxFit.fill,
                      progressIndicatorBuilder: (context, url, progress) => const CustomIndicator(),
                      errorWidget: (context, url, error) => Image.asset(
                        ImagesPath.noImage.assetName,
                        width: double.infinity,
                        height: double.infinity,
                        filterQuality: FilterQuality.high,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(7),
                      child: Text(
                        title ?? '',
                        maxLines: 1,
                        softWrap: false,
                        textScaleFactor: 1,
                        style: TextStyle(
                          fontSize: 14.5.sp,
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
