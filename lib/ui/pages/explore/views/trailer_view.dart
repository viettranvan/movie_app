import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/shared_ui/shared_ui.dart';
import 'package:movie_app/ui/components/components.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class TrailerView extends StatelessWidget {
  const TrailerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        PrimaryText(
          title: 'Official Trailer',
          icon: Icon(
            Icons.play_circle_outline,
            color: greyColor,
          ),
        ),
        Container(
          height: 200.h,
          color: Colors.red,
          child: ListView.separated(
            addRepaintBoundaries: false,
            addAutomaticKeepAlives: false,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.fromLTRB(17.w, 10.h, 17.w, 0.h),
            itemBuilder: itemBuilder,
            separatorBuilder: separatorBuilder,
            itemCount: 4,
          ),
        ),
      ],
    );
  }

  Widget itemBuilder(BuildContext context, int index) {
    final List<String> videoId = [
      'aJ_kaSTnjFo',
      'WXBHCQYxwr0',
      '50-_oTkmF5I',
      'KRaWnd3LJfs',
      'NOubzHCUt48',
      '5jlI4uzZGjU',
    ];
    final List<YoutubePlayerController> controllers = videoId
        .map(
          (e) => YoutubePlayerController.fromVideoId(
            videoId: e,
            autoPlay: true,
            params: const YoutubePlayerParams(
              showControls: true,
              showFullscreenButton: true,
              showVideoAnnotations: true,
              enableCaption: false,
            ),
          ),
        )
        .toList();
    return QuinaryItemList(
      title: 'Wonder Woman 1998',
      releaseYear: '2022',
      imageUrl: 'https://image.tmdb.org/t/p/w500/egg7KFi18TSQc1s24RMmR9i2zO6.jpg',
      onTap: () {
        showDialog(
          barrierColor: Colors.black.withOpacity(0.8),
          context: context,
          builder: (context) => OrientationBuilder(
            builder: (context, orientation) => orientation == Orientation.portrait
                ? Dialog(
                    child: YoutubePlayerScaffold(
                      aspectRatio: 16 / 9,
                      controller: controllers[index],
                      builder: (context, player) => player,
                    ),
                  )
                : Dialog.fullscreen(
                    child: YoutubePlayerScaffold(
                      aspectRatio: 16 / 9,
                      controller: controllers[index],
                      builder: (context, player) => player,
                    ),
                  ),
          ),
        );
      },
    );
  }

  Widget separatorBuilder(BuildContext context, int index) => SizedBox(width: 15.w);
}
