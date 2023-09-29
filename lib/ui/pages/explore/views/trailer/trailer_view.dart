import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/shared_ui/shared_ui.dart';
import 'package:movie_app/ui/components/components.dart';
import 'package:movie_app/ui/pages/details/index.dart';
import 'package:movie_app/ui/pages/explore/bloc/explore_bloc.dart';
import 'package:movie_app/ui/pages/explore/views/trailer/bloc/trailer_bloc.dart';
import 'package:movie_app/utils/constants/constants.dart';
import 'package:movie_app/utils/debouncer/debouncer.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class TrailerView extends StatefulWidget {
  const TrailerView({super.key});

  @override
  State<TrailerView> createState() => _TrailerViewState();
}

class _TrailerViewState extends State<TrailerView> {
  late YoutubePlayerController controller;
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
      child: BlocListener<ExploreBloc, ExploreState>(
        listener: (context, state) {
          final bloc = BlocProvider.of<TrailerBloc>(context);
          state is ExploreSuccess &&
                  (bloc.state.listTrailerMovie.isNotEmpty || bloc.state.listTrailerTv.isNotEmpty)
              ? reloadList(context)
              : null;
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            PrimaryText(
              title: 'Latest Trailer',
              visibleIcon: true,
              hasSwitch: true,
              icon: Icon(
                Icons.play_circle_outline,
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
                    onSwitchMovie: () => switchTheater(context),
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
                    height: 250.h,
                    child: const CustomIndicator(radius: 10),
                  );
                }
                if (state is TrailerError) {
                  return SizedBox(
                    height: 250.h,
                    child: Text(
                      state.errorMessage,
                    ),
                  );
                }
                return NotificationListener<UserScrollNotification>(
                  onNotification: (notification) {
                    scrollToPlay(context);
                    return false;
                  },
                  child: AnimatedCrossFade(
                    duration: const Duration(milliseconds: 400),
                    crossFadeState:
                        state.isActive ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                    firstChild: SizedBox(
                      height: 250.h,
                      child: ListView.separated(
                        addRepaintBoundaries: false,
                        addAutomaticKeepAlives: true,
                        controller: bloc.theaterController,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.fromLTRB(17.w, 15.h, 17.w, 0.h),
                        itemBuilder: itemBuilderTheater,
                        separatorBuilder: separatorBuilder,
                        itemCount: state.listMovie.length,
                      ),
                    ),
                    secondChild: SizedBox(
                      height: 250.h,
                      child: ListView.separated(
                        addRepaintBoundaries: false,
                        addAutomaticKeepAlives: true,
                        controller: bloc.tvController,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.fromLTRB(17.w, 15.h, 17.w, 0.h),
                        itemBuilder: itemBuilderTv,
                        separatorBuilder: separatorBuilder,
                        itemCount: state.listTv.length,
                      ),
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

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget itemBuilderTheater(BuildContext context, int index) {
    final bloc = BlocProvider.of<TrailerBloc>(context);
    final item = bloc.state.listMovie[index];
    final itemTrailer = bloc.state.listTrailerMovie[index];
    controller = YoutubePlayerController(
      initialVideoId: itemTrailer.key ?? '',
      flags: const YoutubePlayerFlags(
        hideControls: true,
        autoPlay: true,
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
      imageUrl: '${AppConstants.kImagePathBackdrop}${item.backdropPath}',
      onEnded: (metdaData) => bloc.add(SwitchType(isActive: bloc.state.isActive)),
      onTap: () => navigateDetailPage(context),
      onLongPress: () => bloc.add(PlayTrailer(
        indexMovie: index,
        visibleVideoMovie: bloc.state.visibleVideoMovie,
        visibleVideoTv: bloc.state.visibleVideoTv,
      )),
    );
  }

  Widget itemBuilderTv(BuildContext context, int index) {
    final bloc = BlocProvider.of<TrailerBloc>(context);
    final item = bloc.state.listTv[index];
    final itemTrailer = bloc.state.listTrailerTv[index];
    controller = YoutubePlayerController(
      initialVideoId: itemTrailer.key ?? '',
      flags: const YoutubePlayerFlags(
        hideControls: true,
        autoPlay: true,
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
      imageUrl: '${AppConstants.kImagePathBackdrop}${item.backdropPath}',
      onEnded: (metdaData) => bloc.add(SwitchType(isActive: bloc.state.isActive)),
      onTap: () => navigateDetailPage(context),
      onLongPress: () => bloc.add(PlayTrailer(
        indexTv: index,
        visibleVideoMovie: bloc.state.visibleVideoMovie,
        visibleVideoTv: bloc.state.visibleVideoTv,
      )),
    );
  }

  Widget separatorBuilder(BuildContext context, int index) => SizedBox(width: 15.w);

  switchTheater(BuildContext context) {
    final bloc = BlocProvider.of<TrailerBloc>(context);
    bloc.add(SwitchType(isActive: false));
    if (bloc.theaterController.hasClients) {
      bloc.theaterController.jumpTo(0);
    }
  }

  switchTv(BuildContext context) {
    final bloc = BlocProvider.of<TrailerBloc>(context);
    bloc.add(SwitchType(isActive: true));
    if (bloc.tvController.hasClients) {
      bloc.tvController.jumpTo(0);
    }
  }

  navigateDetailPage(BuildContext context) {
    final bloc = BlocProvider.of<TrailerBloc>(context);
    bloc.add(SwitchType(isActive: bloc.state.isActive));
    Navigator.of(context).push(
      CustomPageRoute(
        page: const DetailsPage(),
        begin: const Offset(1, 0),
      ),
    );
  }

  scrollToPlay(BuildContext context) {
    final bloc = BlocProvider.of<TrailerBloc>(context);
    if (bloc.state.isActive) {
      double currentPosition = bloc.tvController.position.pixels;
      int currentIndex = (currentPosition / 310.w).round();
      debouncer.slowCall(
        () => bloc.state.visibleVideoTv[currentIndex]
            ? null
            : bloc.add(PlayTrailer(
                indexTv: currentIndex,
                visibleVideoMovie: bloc.state.visibleVideoMovie,
                visibleVideoTv: bloc.state.visibleVideoTv,
              )),
      );
    } else {
      double currentPosition = bloc.theaterController.position.pixels;
      int currentIndex = (currentPosition / 310.w).round();
      debouncer.slowCall(
        () => bloc.state.visibleVideoMovie[currentIndex]
            ? null
            : bloc.add(PlayTrailer(
                indexMovie: currentIndex,
                visibleVideoMovie: bloc.state.visibleVideoMovie,
                visibleVideoTv: bloc.state.visibleVideoTv,
              )),
      );
    }
  }

  reloadList(BuildContext context) {
    final bloc = BlocProvider.of<TrailerBloc>(context);
    bloc.add(FetchData(language: 'en-US', page: 1, region: ''));
    bloc.state is TrailerSuccess ? bloc.add(SwitchType(isActive: false)) : null;
    if (bloc.theaterController.hasClients) {
      bloc.theaterController.animateTo(
        0,
        duration: const Duration(milliseconds: 500),
        curve: Curves.linear,
      );
    }
    if (bloc.tvController.hasClients) {
      bloc.tvController.animateTo(
        0,
        duration: const Duration(milliseconds: 500),
        curve: Curves.linear,
      );
    }
  }
}
