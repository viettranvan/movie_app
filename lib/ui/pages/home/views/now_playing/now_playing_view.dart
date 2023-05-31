import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/shared_ui/colors/color.dart';
import 'package:movie_app/shared_ui/transitions/transitions.dart';
import 'package:movie_app/ui/components/components.dart';
import 'package:movie_app/ui/pages/details/index.dart';
import 'package:movie_app/ui/pages/home/views/now_playing/bloc/now_playing_bloc.dart';
import 'package:movie_app/utils/utils.dart';

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
      child: BlocConsumer<NowPlayingBloc, NowPlayingState>(
        listener: (context, state) {
          if (state.paletteColors.isEmpty) {
            BlocProvider.of<NowPlayingBloc>(context).add(ChangeColor(
              imagePath: '${AppConstants.kImagePathPoster}${state.nowPlayingTv.posterPath}',
            ));
          } else {
            return;
          }
        },
        builder: (context, state) {
          if (state is NowPlayingInitial) {
            return const SizedBox(height: 172);
          }
          if (state is NowPlayingError) {
            return const SizedBox(
              height: 172,
              width: double.infinity,
              child: CustomIndicator(),
            );
          }
          final name = state.nowPlayingTv.name;
          final seasonNumber = state.nowPlayingTv.lastEpisodeToAir?.seasonNumber;
          final episode = state.nowPlayingTv.lastEpisodeToAir?.episodeNumber;
          final overview =
              state.nowPlayingTv.overview != '' ? state.nowPlayingTv.overview : 'Comming soon';
          final posterPath = state.nowPlayingTv.posterPath;
          return ViewItem(
            title: name,
            season: seasonNumber,
            episode: episode,
            overview: overview,
            textColor: state.averageLuminance > 0.5 ? brownColor : whiteColor,
            imageUrl: posterPath != null
                ? '${AppConstants.kImagePathPoster}$posterPath'
                : 'https://nileshsupermarket.com/wp-content/uploads/2022/07/no-image.jpg',
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
