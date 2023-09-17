import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/shared_ui/shared_ui.dart';
import 'package:movie_app/ui/components/components.dart';

class QuaternaryItemList extends StatelessWidget {
  final String? imageUrl;
  final String? originalLanguage;
  final String? title;
  final String? overview;
  final String? releaseDate;
  final String? voteAverage;
  final VoidCallback? onTap;
  const QuaternaryItemList({
    super.key,
    this.imageUrl,
    this.originalLanguage,
    this.title,
    this.overview,
    this.releaseDate,
    this.voteAverage,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: RepaintBoundary(
        child: IntrinsicHeight(
          child: Container(
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.circular(20.r),
              boxShadow: [
                BoxShadow(
                  color: greyColor,
                  blurRadius: 5,
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.max,
              children: [
                Flexible(
                  flex: 3,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(12.w, 11.h, 6.w, 11.h),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          title ?? '',
                          maxLines: 1,
                          softWrap: true,
                          textScaleFactor: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 21.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 6.h),
                        Text(
                          overview ?? 'Coming soon',
                          maxLines: 3,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          textScaleFactor: 1,
                          style: TextStyle(
                            color: greyColor,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        overview!.contains('Coming soon') ? const Spacer() : SizedBox(height: 10.h),
                        Padding(
                          padding: EdgeInsets.fromLTRB(1.w, 0, 8.w, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(
                                Icons.access_time_rounded,
                                size: 18.sp,
                              ),
                              SizedBox(width: 2.w),
                              Flexible(
                                flex: 5,
                                child: Text(
                                  releaseDate ?? '',
                                  maxLines: 1,
                                  softWrap: true,
                                  overflow: TextOverflow.ellipsis,
                                  textScaleFactor: 1,
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                    color: indigoColor,
                                  ),
                                ),
                              ),
                              const Spacer(flex: 3),
                              Text(
                                voteAverage ?? '',
                                textScaleFactor: 1,
                                style: TextStyle(
                                  color: yellowColor,
                                  fontSize: 15.sp,
                                ),
                              ),
                              Icon(
                                Icons.star_rounded,
                                color: yellowColor,
                              ),
                              SizedBox(width: 3.w),
                              Container(
                                width: 23.w,
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(3).w,
                                decoration: BoxDecoration(
                                  color: gainsBoroColor,
                                  borderRadius: BorderRadius.circular(5.r),
                                ),
                                child: Text(
                                  originalLanguage ?? '',
                                  textScaleFactor: 1,
                                  style: TextStyle(
                                    color: whiteColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 90.w,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20.r),
                      bottomRight: Radius.circular(20.r),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: imageUrl ?? '',
                      filterQuality: FilterQuality.high,
                      fit: BoxFit.fill,
                      progressIndicatorBuilder: (context, url, progress) => const CustomIndicator(),
                      errorWidget: (context, url, error) => Image.asset(
                        ImagesPath.noImage.assetName,
                        filterQuality: FilterQuality.high,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
