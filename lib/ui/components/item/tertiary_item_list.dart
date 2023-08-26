import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/shared_ui/colors/color.dart';
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
          width: 120.w,
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
          child: index == itemCount
              ? ItemViewAll(
                  width: 50.w,
                  height: 50.h,
                )
              : Column(
                  children: [
                    SizedBox(
                      height: 171.h,
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15.r),
                          topRight: Radius.circular(15.r),
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
