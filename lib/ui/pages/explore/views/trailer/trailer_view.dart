import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/shared_ui/shared_ui.dart';
import 'package:movie_app/ui/components/components.dart';
import 'package:movie_app/ui/pages/details/details_page.dart';
import 'package:movie_app/ui/pages/explore/bloc/explore_bloc.dart';
import 'package:movie_app/ui/pages/explore/views/trailer/bloc/trailer_bloc.dart';
import 'package:movie_app/utils/constants/constants.dart';

class TrailerView extends StatefulWidget {
  const TrailerView({super.key});

  @override
  State<TrailerView> createState() => _TrailerViewState();
}

class _TrailerViewState extends State<TrailerView> {
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
                return AnimatedCrossFade(
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
    final state = BlocProvider.of<TrailerBloc>(context).state;
    if (state.movieControllers.isNotEmpty) {
      state.movieControllers[0].dispose();
    }
    if (state.tvControllers.isNotEmpty) {
      state.tvControllers[0].dispose();
    }
    super.dispose();
  }

  Widget itemBuilderTheater(BuildContext context, int index) {
    final bloc = BlocProvider.of<TrailerBloc>(context);
    final item = bloc.state.listMovie[index];
    final itemTrailer = bloc.state.listTrailerMovie[index];
    return QuinaryItemList(
      controller: bloc.state.movieControllers.isNotEmpty ? bloc.state.movieControllers[0] : null,
      visibleVideo: bloc.state.visibleVideoMovie[index],
      title: item.title,
      nameOfTrailer: itemTrailer.name ?? 'Official Trailer',
      imageUrl: '${AppConstants.kImagePathBackdrop}${item.backdropPath}',
      onEnded: (metdaData) => bloc.add(ShowVideo(
        indexMovie: index,
        currentIndexMovie: (bloc.state as TrailerSuccess).currentIndexMovie,
        visibleVideoMovie: (bloc.state as TrailerSuccess).visibleVideoMovie,
        visibleVideoTv: bloc.state.visibleVideoTv,
      )),
      onTap: () {
        bloc.add(HideVideo());
        Navigator.of(context).push(
          CustomPageRoute(
            page: const DetailsPage(),
            begin: const Offset(1, 0),
          ),
        );
      },
      onLongPress: () {
        bloc.add(ShowVideo(
          indexMovie: index,
          currentIndexMovie: (bloc.state as TrailerSuccess).currentIndexMovie,
          visibleVideoMovie: (bloc.state as TrailerSuccess).visibleVideoMovie,
          visibleVideoTv: bloc.state.visibleVideoTv,
        ));
        bloc.add(PlayTrailer(
          trailerKey: itemTrailer.key ?? '',
          currentIndexMovie: index,
        ));
      },
    );
  }

  Widget itemBuilderTv(BuildContext context, int index) {
    final bloc = BlocProvider.of<TrailerBloc>(context);
    final item = bloc.state.listTv[index];
    final itemTrailer = bloc.state.listTrailerTv[index];
    return QuinaryItemList(
      controller: bloc.state.tvControllers.isNotEmpty ? bloc.state.tvControllers[0] : null,
      visibleVideo: bloc.state.visibleVideoTv[index],
      title: item.name,
      nameOfTrailer: itemTrailer.name ?? 'Official Trailer',
      imageUrl: '${AppConstants.kImagePathBackdrop}${item.backdropPath}',
      onEnded: (metdaData) => bloc.add(ShowVideo(
        indexTv: index,
        currentIndexTv: (bloc.state as TrailerSuccess).currentIndexTv,
        visibleVideoTv: (bloc.state as TrailerSuccess).visibleVideoTv,
        visibleVideoMovie: bloc.state.visibleVideoMovie,
      )),
      onTap: () {
        bloc.add(HideVideo());
        Navigator.of(context).push(
          CustomPageRoute(
            page: const DetailsPage(),
            begin: const Offset(1, 0),
          ),
        );
      },
      onLongPress: () {
        bloc.add(ShowVideo(
          indexTv: index,
          currentIndexTv: (bloc.state as TrailerSuccess).currentIndexTv,
          visibleVideoTv: (bloc.state as TrailerSuccess).visibleVideoTv,
          visibleVideoMovie: bloc.state.visibleVideoMovie,
        ));
        bloc.add(PlayTrailer(
          trailerKey: itemTrailer.key ?? '',
          currentIndexTv: index,
        ));
      },
    );
  }

  Widget separatorBuilder(BuildContext context, int index) => SizedBox(width: 15.w);

  switchTheater(BuildContext context) {
    final bloc = BlocProvider.of<TrailerBloc>(context);
    bloc.add(FetchData(language: 'en-US', page: 1, region: ''));
    bloc.add(SwitchType(isActive: false));
    if (bloc.theaterController.hasClients) {
      bloc.theaterController.jumpTo(0);
    }
  }

  switchTv(BuildContext context) {
    final bloc = BlocProvider.of<TrailerBloc>(context);
    bloc.add(FetchData(language: 'en-US', page: 1, region: ''));
    bloc.add(SwitchType(isActive: true));
    if (bloc.tvController.hasClients) {
      bloc.tvController.jumpTo(0);
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
