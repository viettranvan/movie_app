import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:movie_app/shared_ui/paths/animations_path.dart';
import 'package:movie_app/shared_ui/shared_ui.dart';
import 'package:movie_app/ui/components/components.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class QuinaryItemList extends StatelessWidget {
  final VoidCallback? onTap;
  final String? title;
  final String imageUrl;
  final String? nameOfTrailer;
  final ObjectKey? youtubeKey;
  final bool visibleVideo;
  final String videoId;
  final YoutubePlayerController controller;
  final Function(YoutubeMetaData)? onEnded;
  final Function()? onLongPress;

  const QuinaryItemList({
    super.key,
    this.onTap,
    this.title,
    this.nameOfTrailer,
    this.onEnded,
    this.onLongPress,
    this.youtubeKey,
    required this.videoId,
    required this.controller,
    required this.imageUrl,
    required this.visibleVideo,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: RepaintBoundary(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 300.w,
              height: 156.h,
              clipBehavior: Clip.antiAlias,
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
              child: visibleVideo
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(20.r),
                      child: YoutubePlayer(
                        width: 300.w,
                        onEnded: onEnded,
                        key: youtubeKey,
                        controller: controller,
                        thumbnail: Stack(
                          alignment: Alignment.center,
                          children: [
                            Positioned.fill(
                              child: CachedNetworkImage(
                                imageUrl: imageUrl,
                                filterQuality: FilterQuality.high,
                                fit: BoxFit.fill,
                                progressIndicatorBuilder: (context, url, progress) =>
                                    const CustomIndicator(),
                                errorWidget: (context, url, error) => Image.asset(
                                  ImagesPath.noImage.assetName,
                                  filterQuality: FilterQuality.high,
                                  fit: BoxFit.fill,
                                  width: double.infinity,
                                  height: double.infinity,
                                ),
                              ),
                            ),
                            Positioned(
                              child: videoId.isNotEmpty
                                  ? Lottie.asset(AnimationsPath.loadingAnimation.assetName,
                                      repeat: true,
                                      addRepaintBoundary: true,
                                      filterQuality: FilterQuality.high,
                                      fit: BoxFit.scaleDown,
                                      height: 50,
                                      width: 80,
                                      delegates: LottieDelegates(
                                        values: [
                                          ValueDelegate.color(
                                            const ['**'],
                                            value: whiteColor,
                                          ),
                                        ],
                                      ))
                                  : BackdropFilter(
                                      blendMode: BlendMode.src,
                                      filter: ImageFilter.blur(
                                        sigmaX: 8,
                                        sigmaY: 8,
                                      ),
                                      child: Container(
                                        alignment: Alignment.center,
                                        color: blackColor.withOpacity(0.6),
                                        child: Text(
                                          'Comming soon 😘',
                                          style: TextStyle(
                                            fontSize: 14.5.sp,
                                            color: whiteColor,
                                          ),
                                        ),
                                      ),
                                    ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned.fill(
                          child: CachedNetworkImage(
                            imageUrl: imageUrl,
                            filterQuality: FilterQuality.high,
                            fit: BoxFit.fill,
                            progressIndicatorBuilder: (context, url, progress) =>
                                const CustomIndicator(),
                            errorWidget: (context, url, error) => Image.asset(
                              ImagesPath.noImage.assetName,
                              filterQuality: FilterQuality.high,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Positioned(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50.r),
                            child: BackdropFilter(
                              blendMode: BlendMode.src,
                              filter: ImageFilter.blur(
                                sigmaX: 8,
                                sigmaY: 8,
                              ),
                              child: Container(
                                color: greyColor.withOpacity(0.3),
                                padding: const EdgeInsets.all(2),
                                child: Icon(
                                  Icons.play_arrow_rounded,
                                  color: whiteColor,
                                  size: 50.sp,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
            ),
            SizedBox(height: 10.h),
            SizedBox(
              width: 300.w,
              child: Text(
                title ?? '',
                softWrap: true,
                textScaleFactor: 1,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14.5.sp,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            SizedBox(
              width: 300.w,
              child: Text(
                '($nameOfTrailer)',
                textScaleFactor: 1,
                softWrap: true,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: greyColor,
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
