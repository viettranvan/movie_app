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
              child: Stack(
                alignment: Alignment.center,
                children: [
                  visibleVideo
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(20.r),
                          child: YoutubePlayer(
                            width: 300.w,
                            onEnded: onEnded,
                            key: youtubeKey,
                            controller: controller,
                            thumbnail: Stack(
                              children: [
                                Positioned.fill(
                                  child: CachedNetworkImage(
                                    width: 300.w,
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
                                Positioned.fill(
                                  child: videoId.isNotEmpty
                                      ? Lottie.asset(AnimationsPath.loadingAnimation.assetName,
                                          repeat: true,
                                          addRepaintBoundary: true,
                                          filterQuality: FilterQuality.high,
                                          fit: BoxFit.scaleDown,
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
                            Positioned(
                              child: CachedNetworkImage(
                                width: 300.w,
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
                ],
              ),
            ),
            SizedBox(height: 10.h),
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
                      text: '($nameOfTrailer)',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: greyColor,
                      ),
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

// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:movie_app/shared_ui/shared_ui.dart';
// import 'package:movie_app/ui/components/components.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// class QuinaryItemList extends StatelessWidget {
//   final VoidCallback? onTap;
//   final String? title;
//   final String imageUrl;
//   final String? nameOfTrailer;
//   final ObjectKey? youtubeKey;
//   final bool visibleVideo;
//   final YoutubePlayerController? controller;
//   final Function(YoutubeMetaData)? onEnded;
//   final Function()? onLongPress;

//   const QuinaryItemList({
//     super.key,
//     this.onTap,
//     this.title,
//     this.nameOfTrailer,
//     this.onEnded,
//     this.onLongPress,
//     this.youtubeKey,
//     this.controller,
//     required this.imageUrl,
//     required this.visibleVideo,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       onLongPress: onLongPress,
//       child: RepaintBoundary(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Container(
//               width: 300.w,
//               height: 156.h,
//               clipBehavior: Clip.antiAlias,
//               decoration: BoxDecoration(
//                 color: whiteColor,
//                 borderRadius: BorderRadius.circular(20.r),
//                 boxShadow: [
//                   BoxShadow(
//                     color: greyColor,
//                     blurRadius: 5,
//                   ),
//                 ],
//               ),
//               child: Stack(
//                 alignment: Alignment.center,
//                 children: [
//                   Visibility(
//                     visible: visibleVideo,
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.circular(20.r),
//                       child: YoutubePlayer(
//                         width: 300.w,
//                         onEnded: onEnded,
//                         key: youtubeKey,
//                         controller: controller ??
//                             YoutubePlayerController(
//                               initialVideoId: '',
//                               flags: const YoutubePlayerFlags(
//                                 hideControls: true,
//                                 autoPlay: false,
//                                 mute: true,
//                                 disableDragSeek: true,
//                                 enableCaption: false,
//                                 useHybridComposition: true,
//                                 forceHD: false,
//                               ),
//                             ),
//                         thumbnail: Stack(
//                           children: [
//                             Positioned.fill(
//                               child: CachedNetworkImage(
//                                 width: 300.w,
//                                 imageUrl: imageUrl,
//                                 filterQuality: FilterQuality.high,
//                                 fit: BoxFit.fill,
//                                 progressIndicatorBuilder: (context, url, progress) =>
//                                     const CustomIndicator(),
//                                 errorWidget: (context, url, error) => Image.asset(
//                                   ImagesPath.noImage.assetName,
//                                   filterQuality: FilterQuality.high,
//                                   fit: BoxFit.fill,
//                                 ),
//                               ),
//                             ),
//                             Positioned.fill(
//                               child: Icon(
//                                 Icons.play_arrow_rounded,
//                                 color: whiteColor,
//                                 size: 50.sp,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                   Visibility(
//                     visible: !visibleVideo,
//                     child: Stack(
//                       children: [
//                         Positioned(
//                           child: CachedNetworkImage(
//                             width: 300.w,
//                             imageUrl: imageUrl,
//                             filterQuality: FilterQuality.high,
//                             fit: BoxFit.fill,
//                             progressIndicatorBuilder: (context, url, progress) =>
//                                 const CustomIndicator(),
//                             errorWidget: (context, url, error) => Image.asset(
//                               ImagesPath.noImage.assetName,
//                               filterQuality: FilterQuality.high,
//                               fit: BoxFit.fill,
//                             ),
//                           ),
//                         ),
//                         Positioned.fill(
//                           child: Icon(
//                             Icons.play_arrow_rounded,
//                             color: whiteColor,
//                             size: 50.sp,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 10),
//             SizedBox(
//               width: 250.w,
//               child: Text.rich(
//                 TextSpan(
//                   children: [
//                     TextSpan(
//                       text: title,
//                     ),
//                     WidgetSpan(
//                       child: SizedBox(
//                         width: 5.w,
//                       ),
//                     ),
//                     TextSpan(
//                       text: '($nameOfTrailer)',
//                       style: TextStyle(
//                         fontSize: 14.sp,
//                         color: greyColor,
//                       ),
//                     ),
//                   ],
//                 ),
//                 softWrap: true,
//                 maxLines: 2,
//                 textScaleFactor: 1,
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   fontSize: 14.5.sp,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // import 'package:cached_network_image/cached_network_image.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_screenutil/flutter_screenutil.dart';
// // import 'package:movie_app/shared_ui/shared_ui.dart';
// // import 'package:movie_app/ui/components/components.dart';
// // import 'package:youtube_player_iframe/youtube_player_iframe.dart';

// // class QuinaryItemList extends StatelessWidget {
// //   final VoidCallback? onTap;
// //   final String? title;
// //   final String imageUrl;
// //   final String? releaseYear;
// //   final Function(YoutubeMetaData)? onEnded;
// //   final YoutubePlayerController controller;
// //   final Function(PointerDownEvent)? onPointerDown;
// //   final bool visibleThumbnail;

// //   const QuinaryItemList({
// //     super.key,
// //     this.onTap,
// //     this.title,
// //     this.releaseYear,
// //     required this.imageUrl,
// //     this.onEnded,
// //     required this.controller,
// //     this.onPointerDown,
// //     required this.visibleThumbnail,
// //   });

// //   @override
// //   Widget build(BuildContext context) {
// //     return GestureDetector(
// //       behavior: HitTestBehavior.opaque,
// //       onTap: onTap,
// //       child: Listener(
// //         onPointerDown: onPointerDown,
// //         child: RepaintBoundary(
// //           child: Column(
// //             mainAxisSize: MainAxisSize.min,
// //             children: [
// //               GestureDetector(
// //                 child: Stack(
// //                   alignment: Alignment.center,
// //                   children: [
// //                     Listener(
// //                       child: ClipRRect(
// //                         borderRadius: BorderRadius.circular(25.r),
// //                         child: SizedBox(
// //                           width: 300.w,
// //                           height: 140.h,
// //                           child: YoutubePlayer(
// //                             controller: controller,
// //                           ),
// //                         ),
// //                       ),
// //                     ),
// //                     Positioned.fill(
// //                       child: Visibility(
// //                         visible: visibleThumbnail,
// //                         child: ClipRRect(
// //                           borderRadius: BorderRadius.circular(25.r),
// //                           child: CachedNetworkImage(
// //                             imageUrl: imageUrl,
// //                             width: 280.w,
// //                             height: 140.h,
// //                             filterQuality: FilterQuality.high,
// //                             fit: BoxFit.fill,
// //                             progressIndicatorBuilder: (context, url, progress) =>
// //                                 const CustomIndicator(),
// //                             errorWidget: (context, url, error) => Image.asset(
// //                               ImagesPath.noImage.assetName,
// //                               filterQuality: FilterQuality.high,
// //                               fit: BoxFit.fill,
// //                             ),
// //                           ),
// //                         ),
// //                       ),
// //                     ),
// //                     Positioned.fill(
// //                       child: Icon(
// //                         Icons.play_arrow_rounded,
// //                         color: whiteColor,
// //                         size: 40.sp,
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //               const SizedBox(height: 10),
// //               SizedBox(
// //                 width: 250.w,
// //                 child: Text.rich(
// //                   TextSpan(
// //                     children: [
// //                       TextSpan(
// //                         text: title,
// //                       ),
// //                       WidgetSpan(
// //                         child: SizedBox(
// //                           width: 5.w,
// //                         ),
// //                       ),
// //                       TextSpan(
// //                         text: '($releaseYear)',
// //                         style: TextStyle(
// //                           fontSize: 14.sp,
// //                           color: greyColor,
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                   softWrap: true,
// //                   maxLines: 2,
// //                   textScaleFactor: 1,
// //                   textAlign: TextAlign.center,
// //                   style: TextStyle(
// //                     fontSize: 14.5.sp,
// //                     overflow: TextOverflow.ellipsis,
// //                   ),
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
