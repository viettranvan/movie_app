import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie_app/shared_ui/shared_ui.dart';
import 'package:movie_app/ui/components/components.dart';
import 'package:movie_app/utils/app_utils/app_utils.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class NonaryItem extends StatefulWidget {
  final String? title;
  final String imageUrl;
  final String? nameOfTrailer;
  final ObjectKey? youtubeKey;
  final bool enableVideo;
  final String videoId;
  final bool? enableSound;
  final VoidCallback? onTapItem;
  final VoidCallback? onTapVideo;
  final VoidCallback? onTapSound;
  final VoidCallback? onTapFullScreen;
  final YoutubePlayerController controller;
  final Function(YoutubeMetaData)? onEnded;

  const NonaryItem({
    super.key,
    this.onTapItem,
    this.title,
    this.nameOfTrailer,
    this.onEnded,
    this.onTapVideo,
    this.youtubeKey,
    this.onTapSound,
    this.onTapFullScreen,
    this.enableSound,
    required this.videoId,
    required this.controller,
    required this.imageUrl,
    required this.enableVideo,
  });

  @override
  State<NonaryItem> createState() => _NonaryItemState();
}

class _NonaryItemState extends State<NonaryItem> {
  int remaningDuration = 0;
  int currentPosition = 0;
  double width = 325.w;
  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: widget.enableVideo ? null : widget.onTapVideo,
            behavior: HitTestBehavior.deferToChild,
            child: Container(
              width: width,
              height: 180.h,
              margin: EdgeInsets.fromLTRB(0, 5.h, 0, 5.h),
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(15.r),
                boxShadow: [
                  BoxShadow(
                    color: greyColor,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: widget.enableVideo
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(15.r),
                      child: YoutubePlayer(
                        width: width,
                        onEnded: widget.onEnded,
                        key: widget.youtubeKey,
                        controller: widget.controller
                          ..addListener(
                            () => setState(() {
                              remaningDuration =
                                  widget.controller.value.metaData.duration.inMilliseconds;
                              currentPosition = widget.controller.value.position.inMilliseconds;
                            }),
                          ),
                        progressColors: ProgressBarColors(
                          playedColor: whiteColor,
                          handleColor: whiteColor,
                          backgroundColor: greyColor,
                          bufferedColor: greyColor.withOpacity(0.5),
                        ),
                        bottomActions: [
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 310.w,
                                child: ProgressBar(
                                  controller: widget.controller,
                                  colors: ProgressBarColors(
                                    playedColor: whiteColor,
                                    handleColor: whiteColor,
                                    backgroundColor: greyColor,
                                    bufferedColor: greyColor.withOpacity(0.5),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10.h),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.w),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    GestureDetector(
                                      onTap: widget.onTapSound,
                                      child: Icon(
                                        (widget.enableSound ?? false)
                                            ? Icons.volume_off
                                            : Icons.volume_up,
                                        color: whiteColor,
                                        size: 20.sp,
                                      ),
                                    ),
                                    SizedBox(width: 20.w),
                                    GestureDetector(
                                      onTap: () => widget.controller.seekTo(
                                        Duration(milliseconds: currentPosition - 10000),
                                      ),
                                      child: SvgPicture.asset(
                                        IconsPath.backwardIcon.assetName,
                                        width: 14.w,
                                        height: 14.h,
                                      ),
                                    ),
                                    SizedBox(width: 15.w),
                                    GestureDetector(
                                      onTap: () => widget.controller.seekTo(
                                        Duration(milliseconds: currentPosition + 10000),
                                      ),
                                      child: SvgPicture.asset(
                                        IconsPath.forwardIcon.assetName,
                                        width: 15.w,
                                        height: 15.h,
                                      ),
                                    ),
                                    SizedBox(width: 10.w),
                                    SizedBox(
                                      width: 80.w,
                                      child: Text(
                                        '${AppUtils().durationFormatter(currentPosition)} / ${AppUtils().durationFormatter(remaningDuration)}',
                                        textAlign: TextAlign.center,
                                        textScaleFactor: 1,
                                        style: TextStyle(
                                          fontSize: 13.sp,
                                          color: whiteColor,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 50.w),
                                    SizedBox(
                                      width: 30.w,
                                      height: 30.h,
                                      child: PlaybackSpeedButton(
                                        controller: widget.controller,
                                      ),
                                    ),
                                    SizedBox(width: 15.w),
                                    GestureDetector(
                                      onTap: widget.onTapFullScreen,
                                      child: Icon(
                                        Icons.zoom_in_map_rounded,
                                        size: 19.sp,
                                        color: whiteColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                        thumbnail: Stack(
                          alignment: Alignment.center,
                          children: [
                            Positioned.fill(
                              child: CachedNetworkImage(
                                imageUrl: widget.imageUrl,
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
                              child: widget.videoId.isNotEmpty
                                  ? const SizedBox()
                                  : BackdropFilter(
                                      blendMode: BlendMode.src,
                                      filter: ImageFilter.blur(
                                        sigmaX: 8,
                                        sigmaY: 8,
                                      ),
                                      child: Container(
                                        padding: EdgeInsets.symmetric(horizontal: 15.w),
                                        alignment: Alignment.center,
                                        color: blackColor.withOpacity(0.6),
                                        child: Text(
                                          '''${widget.title} is comming soon on TMDb''',
                                          textAlign: TextAlign.center,
                                          textScaleFactor: 1,
                                          style: TextStyle(
                                            fontSize: 12.sp,
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
                            imageUrl: widget.imageUrl,
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
                          child: Icon(
                            Icons.play_arrow,
                            color: whiteColor,
                            size: 60.sp,
                            shadows: [
                              BoxShadow(
                                color: greyColor,
                                blurRadius: 5,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
            ),
          ),
          SizedBox(height: 5.h),
          InkWell(
            onTap: widget.onTapItem,
            child: SizedBox(
              width: 300.w,
              child: Text(
                '${widget.title} - ${widget.nameOfTrailer}',
                softWrap: true,
                textScaleFactor: 1,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14.5.sp,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }
}
