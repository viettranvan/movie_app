import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/shared_ui/shared_ui.dart';
import 'package:movie_app/ui/components/components.dart';
import 'package:movie_app/ui/pages/details/index.dart';
import 'package:movie_app/ui/pages/explore/bloc/explore_bloc.dart';
import 'package:movie_app/ui/pages/explore/views/trailer/bloc/trailer_bloc.dart';
import 'package:movie_app/ui/pages/navigation/bloc/navigation_bloc.dart';
import 'package:movie_app/utils/constants/constants.dart';
import 'package:movie_app/utils/debouncer/debouncer.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class TrailerView extends StatefulWidget {
  const TrailerView({super.key});

  @override
  State<TrailerView> createState() => _TrailerViewState();
}

class _TrailerViewState extends State<TrailerView> {
  Debouncer debouncer = Debouncer();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TrailerBloc()
        ..add(FetchData(
          language: 'en-US',
          page: 1,
          region: '',
        )),
      child: BlocListener<NavigationBloc, NavigationState>(
        listener: (context, state) {
          final trailerState = BlocProvider.of<TrailerBloc>(context).state;
          final exploreBloc = BlocProvider.of<ExploreBloc>(context);
          switch (state.runtimeType) {
            case NavigationSuccess:
              state.indexPage == 1
                  ? trailerState is TrailerSuccess
                      ? exploreBloc.scrollController.position.extentBefore <= 0
                          ? checkDisplayVideo(context)
                              ? null
                              : playTrailer(context, trailerState.indexMovie, trailerState.indexTv)
                          : checkDisplayVideo(context)
                              ? stopTrailer(context, trailerState.indexMovie, trailerState.indexTv)
                              : null
                      : stopTrailer(context, trailerState.indexMovie, trailerState.indexTv)
                  : checkDisplayVideo(context)
                      ? stopTrailer(context, trailerState.indexMovie, trailerState.indexTv)
                      : null;
              break;
            case NavigationScrollSuccess:
              state.indexPage == 1
                  ? trailerState is TrailerSuccess
                      ? checkDisplayVideo(context)
                          ? null
                          : playTrailer(context, trailerState.indexMovie, trailerState.indexTv)
                      : stopTrailer(context, trailerState.indexMovie, trailerState.indexTv)
                  : checkDisplayVideo(context)
                      ? stopTrailer(context, trailerState.indexMovie, trailerState.indexTv)
                      : null;
              break;
            default:
              break;
          }
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            PrimaryText(
              title: 'TMDb Originals',
              visibleIcon: true,
              hasSwitch: true,
              icon: Icon(
                Icons.video_library_rounded,
                size: 24,
                color: greyColor,
              ),
              child: BlocBuilder<TrailerBloc, TrailerState>(
                builder: (context, state) {
                  if (state is TrailerError) {
                    return SizedBox(height: 22.h);
                  }
                  return CustomSwitch(
                    firstTitle: 'Theaters',
                    secondTitle: 'TV',
                    isActive: state.isActive,
                    onSwitchMovie: () => switchMovie(context),
                    onSwitchTV: () => switchTv(context),
                  );
                },
              ),
            ),
            BlocBuilder<TrailerBloc, TrailerState>(
              builder: (context, state) {
                final bloc = BlocProvider.of<TrailerBloc>(context);
                if (state is TrailerInitial) {
                  return SizedBox(
                    height: 240.h,
                    child: const CustomIndicator(radius: 10),
                  );
                }
                if (state is TrailerError) {
                  return SizedBox(
                    height: 240.h,
                    child: Center(
                      child: Text(state.runtimeType.toString()),
                    ),
                  );
                }
                return AnimatedCrossFade(
                  duration: const Duration(milliseconds: 400),
                  crossFadeState:
                      state.isActive ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                  firstChild: Container(
                    height: 240.h,
                    padding: EdgeInsets.fromLTRB(0, 15.h, 0, 0),
                    child: PageView.builder(
                      physics: const BouncingScrollPhysics(),
                      allowImplicitScrolling: true,
                      controller: bloc.movieController,
                      itemCount: state.listMovie.length,
                      itemBuilder: itemBuilderMovie,
                      onPageChanged: (value) {
                        stopTrailer(context, state.indexMovie, state.indexTv);
                        bloc.state.visibleVideoMovie[value]
                            ? null
                            : playTrailer(context, value, state.indexTv);
                      },
                    ),
                  ),
                  secondChild: Container(
                    height: 240.h,
                    padding: EdgeInsets.fromLTRB(0, 15.h, 0, 0),
                    child: PageView.builder(
                        physics: const BouncingScrollPhysics(),
                        allowImplicitScrolling: true,
                        controller: bloc.tvController,
                        itemCount: state.listTv.length,
                        itemBuilder: itemBuilderTv,
                        onPageChanged: (value) {
                          stopTrailer(context, state.indexMovie, state.indexTv);
                          bloc.state.visibleVideoTv[value]
                              ? null
                              : playTrailer(context, state.indexMovie, value);
                        }),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget itemBuilderMovie(BuildContext context, int index) {
    final bloc = BlocProvider.of<TrailerBloc>(context);
    final item = bloc.state.listMovie[index];
    final itemTrailer = bloc.state.listTrailerMovie[index];
    final controller = YoutubePlayerController(
      initialVideoId: itemTrailer.key ?? '',
      flags: YoutubePlayerFlags(
        hideControls: true,
        autoPlay: bloc.state.visibleVideoMovie[index] ? true : false,
        mute: false,
        disableDragSeek: true,
        enableCaption: false,
        useHybridComposition: true,
        forceHD: false,
      ),
    );
    return QuinaryItemList(
      videoId: itemTrailer.key ?? '',
      youtubeKey: ObjectKey(controller),
      controller: controller,
      visibleVideo: bloc.state.visibleVideoMovie[index],
      title: item.title,
      nameOfTrailer: itemTrailer.name ?? 'Coming soon',
      isActive: bloc.state.isActive,
      imageUrl: item.backdropPath == null
          ? 'https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcTxZYNhrWgfQyqlnGPwzVDe5xv5oPVljnimLLixVAADAItCD6lu'
          : '${AppConstants.kImagePathBackdrop}${item.backdropPath}',
      onEnded: (metdaData) => stopTrailer(context, index, bloc.state.indexTv),
      onTap: () => navigateDetailPage(context),
      onLongPress: () => bloc.state.visibleVideoMovie[index]
          ? stopTrailer(context, index, bloc.state.indexTv)
          : playTrailer(context, index, bloc.state.indexTv),
    );
  }

  Widget itemBuilderTv(BuildContext context, int index) {
    final bloc = BlocProvider.of<TrailerBloc>(context);
    final item = bloc.state.listTv[index];
    final itemTrailer = bloc.state.listTrailerTv[index];
    final controller = YoutubePlayerController(
      initialVideoId: itemTrailer.key ?? '',
      flags: YoutubePlayerFlags(
        hideControls: true,
        autoPlay: bloc.state.visibleVideoTv[index] ? true : false,
        mute: false,
        disableDragSeek: true,
        enableCaption: false,
        useHybridComposition: true,
        forceHD: false,
      ),
    );
    return QuinaryItemList(
      videoId: itemTrailer.key ?? '',
      youtubeKey: ObjectKey(controller),
      controller: controller,
      visibleVideo: bloc.state.visibleVideoTv[index],
      title: item.name,
      nameOfTrailer: itemTrailer.name ?? 'Coming soon',
      isActive: bloc.state.isActive,
      imageUrl: item.backdropPath == null
          ? 'https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcTxZYNhrWgfQyqlnGPwzVDe5xv5oPVljnimLLixVAADAItCD6lu'
          : '${AppConstants.kImagePathBackdrop}${item.backdropPath}',
      onEnded: (metdaData) => stopTrailer(context, bloc.state.indexMovie, index),
      onTap: () => navigateDetailPage(context),
      onLongPress: () => bloc.state.visibleVideoTv[index]
          ? stopTrailer(context, bloc.state.indexMovie, index)
          : playTrailer(context, bloc.state.indexMovie, index),
    );
  }

  switchMovie(BuildContext context) {
    final bloc = BlocProvider.of<TrailerBloc>(context);
    bloc.add(SwitchType(isActive: false));
    playTrailer(context, bloc.state.indexMovie, bloc.state.indexTv);
  }

  switchTv(BuildContext context) {
    final bloc = BlocProvider.of<TrailerBloc>(context);
    bloc.add(SwitchType(isActive: true));
    playTrailer(context, bloc.state.indexMovie, bloc.state.indexTv);
  }

  navigateDetailPage(BuildContext context) {
    final bloc = BlocProvider.of<TrailerBloc>(context);
    stopTrailer(context, bloc.state.indexMovie, bloc.state.indexTv);
    Navigator.of(context)
        .push(CustomPageRoute(
          page: const DetailsPage(),
          begin: const Offset(1, 0),
        ))
        .then(
          (_) => playTrailer(context, bloc.state.indexMovie, bloc.state.indexTv),
        );
  }

  playTrailer(BuildContext context, int indexMovie, int indexTv) {
    final bloc = BlocProvider.of<TrailerBloc>(context);
    debouncer.slowCall(
      () => bloc.add(PlayTrailer(
        indexMovie: indexMovie,
        indexTv: indexTv,
        isActive: bloc.state.isActive,
        visibleVideoMovie: bloc.state.visibleVideoMovie,
        visibleVideoTv: bloc.state.visibleVideoTv,
      )),
    );
  }

  stopTrailer(BuildContext context, int indexMovie, int indexTv) {
    final bloc = BlocProvider.of<TrailerBloc>(context);
    bloc.add(StopTrailer(
      indexMovie: indexMovie,
      indexTv: indexTv,
      isActive: bloc.state.isActive,
      visibleVideoMovie: bloc.state.visibleVideoMovie,
      visibleVideoTv: bloc.state.visibleVideoTv,
    ));
  }

  bool checkDisplayVideo(BuildContext context) {
    final trailerState = BlocProvider.of<TrailerBloc>(context).state;
    return trailerState.visibleVideoMovie[trailerState.indexMovie] ||
        trailerState.visibleVideoTv[trailerState.indexTv];
  }
}
