import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/shared_ui/colors/colors.dart';
import 'package:movie_app/shared_ui/transitions/transitions.dart';
import 'package:movie_app/ui/details/details_page.dart';
import 'package:movie_app/ui/home/views/now_playing/bloc/now_playing_bloc.dart';
import 'package:movie_app/ui/home/views/now_playing/widgets/index.dart';
import 'package:movie_app/utils/utils.dart';

class NowPlayingView extends StatefulWidget {
  const NowPlayingView({super.key});

  @override
  State<NowPlayingView> createState() => _NowPlayingViewState();
}

class _NowPlayingViewState extends State<NowPlayingView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NowPlayingBloc()
        ..add(FetchData(
          language: 'en-US',
          page: 1,
        )),
      child: BlocConsumer<NowPlayingBloc, NowPlayingState>(
        listener: (context, state) {
          if (state is NowPlayingSuccess) {
            BlocProvider.of<NowPlayingBloc>(context).add(
              ChangeColor(
                imagePath: '${AppConstants.kImagePathPoster}${state.nowPlayingTv.posterPath}',
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is NowPlayingInitial) {
            return const SizedBox(height: 175);
          }
          return ItemNowPlaying(
            title: state.nowPlayingTv.name,
            season: state.nowPlayingTv.lastEpisodeToAir?.seasonNumber,
            episode: state.nowPlayingTv.lastEpisodeToAir?.episodeNumber,
            overview:
                state.nowPlayingTv.overview != '' ? state.nowPlayingTv.overview : 'Comming soon',
            textColor: state.averageLuminance > 0.5 ? brownColor : whiteColor,
            imageUrl: '${AppConstants.kImagePathPoster}${state.nowPlayingTv.posterPath}',
            colors: state.paletteColors,
            stops: List.generate(state.paletteColors.length, (index) => index * 0.13),
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
