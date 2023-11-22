import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie_app/shared_ui/colors/color.dart';
import 'package:movie_app/shared_ui/paths/images_path.dart';
import 'package:movie_app/shared_ui/transitions/transitions.dart';
import 'package:movie_app/ui/components/components.dart';
import 'package:movie_app/ui/pages/details/index.dart';
import 'package:movie_app/ui/pages/home/bloc/home_bloc.dart';
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
      child: BlocListener<HomeBloc, HomeState>(
        listener: (context, state) {
          final bloc = BlocProvider.of<NowPlayingBloc>(context);
          state is HomeSuccess && bloc.state.paletteColors.isNotEmpty ? reloadItem(context) : null;
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            PrimaryText(
              title: 'Now Playing',
              visibleIcon: true,
              onTapViewAll: () {},
              icon: SvgPicture.asset(
                ImagesPath.nowPlayingIcon.assetName,
              ),
            ),
            SizedBox(height: 15.h),
            BlocConsumer<NowPlayingBloc, NowPlayingState>(
              listener: (context, state) {
                final bloc = BlocProvider.of<NowPlayingBloc>(context);
                state.paletteColors.isEmpty && state is NowPlayingSuccess
                    ? bloc.add(ChangeColor(
                        posterPath: (state.nowPlayingTv.posterPath ?? '').isNotEmpty
                            ? '${AppConstants.kImagePathPoster}${state.nowPlayingTv.posterPath}'
                            : ImagesPath.noImage.assetName,
                      ))
                    : null;
              },
              builder: (context, state) {
                if (state is NowPlayingInitial) {
                  return SizedBox(
                    height: 172.h,
                    child: const CustomIndicator(),
                  );
                }
                if (state is NowPlayingError) {
                  return SizedBox(
                    height: 172.h,
                    child: Center(
                      child: Text(state.errorMessage),
                    ),
                  );
                }
                final name = state.nowPlayingTv.name;
                final seasonNumber = state.nowPlayingTv.lastEpisodeToAir?.seasonNumber;
                final episode = state.nowPlayingTv.lastEpisodeToAir?.episodeNumber;
                final overview = state.nowPlayingTv.overview != ''
                    ? state.nowPlayingTv.overview
                    : 'Comming soon';
                final posterPath = state.nowPlayingTv.posterPath;
                return ViewItem(
                  title: name,
                  season: seasonNumber,
                  episode: episode,
                  overview: overview,
                  textColor: state.averageLuminance > 0.5 || state.nowPlayingTv.posterPath == null
                      ? blackColor
                      : whiteColor,
                  imageUrl: '${AppConstants.kImagePathPoster}$posterPath',
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
          ],
        ),
      ),
    );
  }

  reloadItem(BuildContext context) => BlocProvider.of<NowPlayingBloc>(context).add(FetchData(
        language: 'en-US',
        page: 1,
      ));
}
