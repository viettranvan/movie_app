import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie_app/shared_ui/shared_ui.dart';
import 'package:movie_app/ui/components/components.dart';

class SenaryItemList extends StatelessWidget {
  final VoidCallback? onTapItem;
  final VoidCallback? onTapBanner;
  final String imageUrl;
  final String? rank;
  final String? title;
  final String? voteAverage;
  final double? initialRating;
  const SenaryItemList({
    super.key,
    this.onTapItem,
    this.onTapBanner,
    this.title,
    this.rank,
    this.voteAverage,
    this.initialRating,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapItem,
      child: RepaintBoundary(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: 220.w,
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
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CachedNetworkImage(
                    imageUrl: imageUrl,
                    filterQuality: FilterQuality.high,
                    width: double.infinity,
                    height: 260.h,
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
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      rank ?? '',
                      maxLines: 1,
                      softWrap: false,
                      textScaleFactor: 1,
                      style: TextStyle(
                        color: greyColor,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: RatingBar.builder(
                      initialRating: initialRating ?? 0.0,
                      updateOnDrag: true,
                      unratedColor: lightGreyColor,
                      itemSize: 18.w,
                      allowHalfRating: true,
                      ignoreGestures: true,
                      onRatingUpdate: (value) {},
                      itemCount: 10,
                      itemBuilder: (context, index) => Icon(
                        Icons.star_rounded,
                        color: yellowColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      voteAverage ?? '',
                      maxLines: 1,
                      softWrap: false,
                      textScaleFactor: 1,
                      style: TextStyle(
                        color: greyColor,
                        fontSize: 14.sp,
                        overflow: TextOverflow.clip,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      title ?? '',
                      maxLines: 1,
                      softWrap: false,
                      textScaleFactor: 1,
                      style: TextStyle(
                        fontSize: 15.sp,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            Positioned(
              top: -3,
              left: 5,
              child: GestureDetector(
                onTap: onTapBanner,
                child: Stack(
                  children: [
                    SvgPicture.asset(
                      ImagesPath.watchListIcon.assetName,
                      height: 55.h,
                      fit: BoxFit.fill,
                      colorFilter: ColorFilter.mode(
                        blackColor.withOpacity(0.5),
                        BlendMode.srcIn,
                      ),
                    ),
                    Positioned(
                      top: 5.h,
                      bottom: 10.h,
                      left: 10.w,
                      right: 10.w,
                      child: Icon(
                        Icons.add,
                        color: whiteColor,
                        size: 30.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
