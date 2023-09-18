import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/shared_ui/shared_ui.dart';
import 'package:movie_app/ui/components/components.dart';
import 'package:movie_app/ui/pages/explore/views/latest_trailer/bloc/latest_trailer_bloc.dart';
import 'package:movie_app/utils/constants/constants.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class LatestTrailerView extends StatelessWidget {
  const LatestTrailerView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TrailerBloc()
        ..add(FetchData(
          language: 'en-US',
          page: 1,
          region: '',
        )),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          PrimaryText(
            title: 'Latest Trailer',
            icon: Icon(
              Icons.play_circle_outline,
              color: greyColor,
            ),
          ),
          BlocBuilder<TrailerBloc, TrailerState>(
            builder: (context, state) {
              return Container(
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
                  itemCount: state.listTopRated.length,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget itemBuilder(BuildContext context, int index) {
    final item = BlocProvider.of<TrailerBloc>(context).state.listTopRated[index];
    final controller = YoutubePlayerController.fromVideoId(
      videoId: 'aJ_kaSTnjFo',
      autoPlay: true,
      params: const YoutubePlayerParams(
        showControls: true,
        showFullscreenButton: true,
        showVideoAnnotations: true,
        enableCaption: false,
      ),
    );
    return QuinaryItemList(
      title: item.title,
      releaseYear: item.releaseDate != null ? item.releaseDate?.substring(0, 4) : 'Unknown',
      imageUrl: '${AppConstants.kImagePathBackdrop}${item.backdropPath}',
      onTap: () {
        showDialog(
          barrierColor: Colors.black.withOpacity(0.8),
          context: context,
          builder: (context) => OrientationBuilder(
            builder: (context, orientation) => orientation == Orientation.portrait
                ? Dialog(
                    child: YoutubePlayerScaffold(
                      aspectRatio: 16 / 9,
                      controller: controller,
                      builder: (context, player) => player,
                    ),
                  )
                : Dialog(
                    child: YoutubePlayerScaffold(
                      aspectRatio: 16 / 9,
                      controller: controller,
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
