import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/shared_ui/shared_ui.dart';
import 'package:movie_app/ui/components/components.dart';

class GridItem extends StatelessWidget {
  final String imageUrl;
  final String? title;
  final String? releaseYear;
  final VoidCallback? onTap;
  const GridItem({
    super.key,
    required this.imageUrl,
    this.onTap,
    this.title,
    this.releaseYear,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: RepaintBoundary(
        child: IntrinsicHeight(
          child: SizedBox(
            height: 300.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: darkWhiteColor,
                    borderRadius: BorderRadius.circular(20.r),
                    boxShadow: [
                      BoxShadow(
                        color: lightGreyColor,
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    filterQuality: FilterQuality.high,
                    fit: BoxFit.fill,
                    height: 240.h,
                    width: double.infinity,
                    progressIndicatorBuilder: (context, url, prgress) => const CustomIndicator(),
                    errorWidget: (context, url, error) => Image.asset(
                      ImagesPath.noImage.assetName,
                      width: double.infinity,
                      height: 240.h,
                      filterQuality: FilterQuality.high,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                SizedBox(height: 15.h),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: title,
                        style: TextStyle(
                          color: blackColor,
                          fontSize: 15.sp,
                        ),
                      ),
                      WidgetSpan(
                        child: SizedBox(width: 5.w),
                      ),
                      TextSpan(
                        text: releaseYear,
                        style: TextStyle(
                          color: greyColor,
                          fontSize: 15.sp,
                        ),
                      ),
                    ],
                  ),
                  maxLines: 2,
                  softWrap: true,
                  textScaleFactor: 1,
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
