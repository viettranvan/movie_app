import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie_app/shared_ui/shared_ui.dart';
import 'package:movie_app/ui/components/components.dart';
import 'package:movie_app/ui/pages/details/index.dart';
import 'package:movie_app/ui/pages/explore/bloc/explore_bloc.dart';
import 'package:movie_app/ui/pages/explore/views/top_rated/bloc/top_rated_bloc.dart';
import 'package:movie_app/utils/utils.dart';

class TopRatedView extends StatelessWidget {
  const TopRatedView({super.key});

  @override
  Widget build(BuildContext context) {
    String sessionId = '566e05bbb7e5ce24132f9aa1b1e2cdf3cb0bf1fb';
    return BlocProvider(
      create: (context) => TopRatedBloc()
        ..add(FetcData(
          page: 1,
          language: 'en-US',
          region: '',
          sessionId: sessionId,
        )),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          PrimaryText(
            title: 'Top 10 rated movies',
            visibleIcon: true,
            onTapViewAll: () {},
            icon: SvgPicture.asset(
              IconsPath.topRatedIcon.assetName,
            ),
          ),
          BlocConsumer<TopRatedBloc, TopRatedState>(
            listener: (context, state) {
              final exploreBloc = BlocProvider.of<ExploreBloc>(context);
              if (state is TopRatedAddWatchListSuccess) {
                showToast(
                    context,
                    state.listMovieState[state.index].watchlist == false
                        ? '${state.listTopRated[state.index].title} was added to Watchlist'
                        : '${state.listTopRated[state.index].title} was removed from Watchlist');
              }
              if (state is TopRatedAddWatchListError) {
                exploreBloc.add(DisplayToast(
                  visibility: true,
                  statusMessage: state.errorMessage,
                ));
                exploreBloc.add(ChangeAnimationToast(opacity: 1.0));
                Timer(
                  const Duration(seconds: 2),
                  () => exploreBloc.add(ChangeAnimationToast(opacity: 0.0)),
                );
              }
            },
            builder: (context, state) {
              if (state is TopRatedInitial) {
                return SizedBox(
                  height: 400.h,
                  child: const CustomIndicator(),
                );
              }
              if (state is TopRatedError) {
                return SizedBox(
                  height: 400.h,
                  child: Center(
                    child: Text(state.runtimeType.toString()),
                  ),
                );
              }
              return SizedBox(
                height: 405.h,
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  addAutomaticKeepAlives: false,
                  addRepaintBoundaries: false,
                  padding: EdgeInsets.fromLTRB(17.w, 20.h, 17.w, 0),
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: itemBuilder,
                  separatorBuilder: separatorBuilder,
                  itemCount: (state.listTopRated.length / 2).round(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget itemBuilder(BuildContext context, int index) {
    final bloc = BlocProvider.of<TopRatedBloc>(context);
    final item = bloc.state.listTopRated[index];
    String? title = item.title ?? '';
    String? posterPath = item.posterPath;
    double voteAverage = double.parse(item.voteAverage?.toStringAsFixed(1) ?? '');
    return SenaryItem(
      title: title,
      rank: '${index + 1}',
      voteAverage: '$voteAverage',
      initialRating: voteAverage,
      imageUrl: '${AppConstants.kImagePathPoster}$posterPath',
      watchList: bloc.state.listMovieState[index].watchlist,
      onTapBanner: () => !(bloc.state.listMovieState[index].watchlist ?? false)
          ? addWatchList(context, index)
          : bloc.state is TopRatedAddWatchListSuccess
              ? null
              : showCupertinoModalPopup(
                  context: context,
                  builder: (secondContext) => CustomBottomSheet(
                    title: '$title (${item.releaseDate?.substring(0, 4)})',
                    titleConfirm: 'Remove from Watchlist',
                    titleCancel: 'Cancel',
                    onPressCancel: () => Navigator.of(secondContext).pop(),
                    onPressConfirm: () => removeWatchList(context, secondContext, index),
                  ),
                ),
      onTapItem: () => Navigator.of(context).push(
        CustomPageRoute(
          page: const DetailsPage(),
          begin: const Offset(1, 0),
        ),
      ),
    );
  }

  Widget separatorBuilder(BuildContext context, int index) => SizedBox(width: 14.w);

  addWatchList(BuildContext context, int index) {
    String sessionId = '566e05bbb7e5ce24132f9aa1b1e2cdf3cb0bf1fb';
    final bloc = BlocProvider.of<TopRatedBloc>(context);
    bloc.add(AddWatchList(
      accountId: 11429392,
      sessionId: sessionId,
      mediaType: 'movie',
      mediaId: bloc.state.listTopRated[index].id ?? 0,
      watchlist: !(bloc.state.listMovieState[index].watchlist ?? false),
      index: index,
    ));
  }

  removeWatchList(BuildContext firstContext, BuildContext secondContext, int index) {
    Navigator.of(secondContext).pop();
    addWatchList(firstContext, index);
  }

  showToast(BuildContext context, String statusMessage) {
    String sessionId = '566e05bbb7e5ce24132f9aa1b1e2cdf3cb0bf1fb';
    final bloc = BlocProvider.of<TopRatedBloc>(context);
    final exploreBloc = BlocProvider.of<ExploreBloc>(context);
    Future.delayed(
      const Duration(milliseconds: 100),
      () => bloc.add(FetcData(
        page: 1,
        language: 'en-US',
        region: '',
        sessionId: sessionId,
      )),
    )
        .then(
          (_) => exploreBloc.add(DisplayToast(
            visibility: true,
            statusMessage: statusMessage,
          )),
        )
        .then(
          (_) => exploreBloc.add(ChangeAnimationToast(opacity: 1.0)),
        );
    Timer(
      const Duration(seconds: 2),
      () => exploreBloc.add(ChangeAnimationToast(opacity: 0.0)),
    );
  }
}
