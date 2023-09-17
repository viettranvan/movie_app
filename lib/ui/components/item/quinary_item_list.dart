import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/shared_ui/shared_ui.dart';
import 'package:movie_app/ui/components/components.dart';

class QuinaryItemList extends StatelessWidget {
  final VoidCallback? onTap;
  final String? title;
  final String imageUrl;
  final String? releaseYear;
  const QuinaryItemList({
    super.key,
    this.onTap,
    this.title,
    this.releaseYear,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.r),
                boxShadow: [
                  BoxShadow(
                    color: greyColor,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25.r),
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  filterQuality: FilterQuality.high,
                  fit: BoxFit.fill,
                  width: 280.w,
                  height: 140.h,
                  progressIndicatorBuilder: (context, url, progress) => const CustomIndicator(),
                  errorWidget: (context, url, error) => Image.asset(
                    ImagesPath.noImage.assetName,
                    filterQuality: FilterQuality.high,
                    fit: BoxFit.fill,
                    width: 100.w,
                    height: 140.h,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: 250.w,
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: title,
                    ),
                    WidgetSpan(
                      child: SizedBox(
                        width: 5.w,
                      ),
                    ),
                    TextSpan(
                      text: '($releaseYear)',
                    ),
                  ],
                ),
                softWrap: true,
                maxLines: 2,
                textScaleFactor: 1,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14.5.sp,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
