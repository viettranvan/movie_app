import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/shared_ui/colors/colors.dart';
import 'package:movie_app/shared_ui/transitions/transitions.dart';
import 'package:movie_app/ui/details/details_page.dart';
import 'package:movie_app/ui/home/views/now_playing/bloc/now_playing_bloc.dart';
import 'package:movie_app/ui/home/views/now_playing/widgets/index.dart';
import 'package:movie_app/utils/index.dart';

class NowPlayingView extends StatelessWidget {
  const NowPlayingView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NowPlayingBloc()
        ..add(FetchData(
          language: 'en-US',
          page: 1,
        )),
      child: BlocBuilder<NowPlayingBloc, NowPlayingState>(
        builder: (context, state) {
          if (state is NowPlayingInitial) {
            return const SizedBox(height: 175);
          }
          return ItemNowPlaying(
            title: state.nowPlayingTv.name,
            season: state.nowPlayingTv.lastEpisodeToAir?.seasonNumber, // lay latest season
            episode: state.nowPlayingTv.lastEpisodeToAir?.episodeNumber, // lay latest episode
            overview:
                state.nowPlayingTv.overview != '' ? state.nowPlayingTv.overview : 'Comming soon',
            image: Image.network(
              '${AppConstants.kImagePathPoster}${state.nowPlayingTv.posterPath}',
            ).image,
            colors: [darkTealColor, tealColor],
            onTap: () => Navigator.of(context).push(
              CustomPageRoute(
                page: const DetailsPage(),
                begin: const Offset(1, 0),
              ),
            ),
          );
        },
      ),
    );
  }
}
