import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie_app/shared_ui/shared_ui.dart';

class SingleItem extends StatelessWidget {
  final VoidCallback? onTap;
  final String imageUrl;
  final List<Color> colors;
  final List<double> stops;
  final Color? textColor;
  final String? title;
  final int? season;
  final int? episode;
  final String? overview;
  const SingleItem({
    super.key,
    this.onTap,
    required this.imageUrl,
    required this.colors,
    this.title,
    this.season,
    this.episode,
    this.overview,
    required this.stops,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: RepaintBoundary(
        child: Container(
          height: 172.h,
          clipBehavior: Clip.antiAlias,
          margin: EdgeInsets.fromLTRB(17.w, 0, 17.w, 0),
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
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CachedNetworkImage(
                width: 115.w,
                imageUrl: imageUrl,
                filterQuality: FilterQuality.high,
                fit: BoxFit.fill,
                progressIndicatorBuilder: (context, url, progress) => SizedBox(
                  height: 172.h,
                  child: Center(
                    child: CupertinoActivityIndicator(
                      color: darkBlueColor,
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => Image.asset(
                  ImagesPath.noImage.assetName,
                  width: 115.w,
                  filterQuality: FilterQuality.high,
                  fit: BoxFit.fill,
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15.r),
                      bottomRight: Radius.circular(15.r),
                    ),
                    gradient: colors.length >= 2 && colors.length == stops.length
                        ? LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            stops: stops,
                            colors: colors,
                          )
                        : null,
                  ),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(15.w, 0, 25.w, 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: 10.h),
                        Text(
                          title ?? '',
                          overflow: TextOverflow.clip,
                          softWrap: false,
                          textScaleFactor: 1,
                          style: TextStyle(
                            color: textColor,
                            fontSize: 20.sp,
                          ),
                        ),
                        SizedBox(height: 1.h),
                        Text(
                          'Season $season | Episode $episode',
                          overflow: TextOverflow.clip,
                          softWrap: false,
                          textScaleFactor: 1,
                          style: TextStyle(
                            color: textColor,
                            fontSize: 14.sp,
                          ),
                        ),
                        SizedBox(height: 11.h),
                        Text(
                          overview ?? '',
                          maxLines: 4,
                          softWrap: false,
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.ellipsis,
                          textScaleFactor: 1.1,
                          style: TextStyle(
                            color: textColor,
                            fontSize: 12.sp,
                          ),
                        ),
                        const Spacer(),
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SvgPicture.asset(
                                IconsPath.tvShowIcon.assetName,
                                colorFilter: ColorFilter.mode(
                                  textColor ?? whiteColor,
                                  BlendMode.srcIn,
                                ),
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                'Watch now!',
                                textScaleFactor: 1,
                                style: TextStyle(
                                  color: textColor,
                                  fontSize: 18.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10.h),
                      ],
                    ),
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
