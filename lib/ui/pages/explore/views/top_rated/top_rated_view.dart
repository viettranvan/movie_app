import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
              ImagesPath.topRatedIcon.assetName,
            ),
          ),
          SizedBox(height: 15.h),
          BlocConsumer<TopRatedBloc, TopRatedState>(
            listener: (context, state) {
              final bloc = BlocProvider.of<TopRatedBloc>(context);
              final exploreBloc = BlocProvider.of<ExploreBloc>(context);
              if (state is TopRatedAddWatchListSuccess) {
                bloc.add(FetcData(
                  page: 1,
                  language: 'en-US',
                  region: '',
                  sessionId: sessionId,
                ));
                exploreBloc.add(ShowStatus(
                    statusMessage: state.listMovieState[state.index].watchlist == false
                        ? '${state.listTopRated[state.index].title} was added to Watchlist'
                        : '${state.listTopRated[state.index].title} was removed from Watchlist'));
                Timer(const Duration(seconds: 2), () => exploreBloc.add(HideStatus()));
              }
              if (state is TopRatedAddWatchListError) {
                BlocProvider.of<ExploreBloc>(context).add(ShowStatus(
                  statusMessage: state.errorMessage,
                ));
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
                height: 400.h,
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  addAutomaticKeepAlives: false,
                  addRepaintBoundaries: false,
                  padding: EdgeInsets.fromLTRB(17.w, 5.h, 17.w, 5.h),
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
    String sessionId = '566e05bbb7e5ce24132f9aa1b1e2cdf3cb0bf1fb';
    final bloc = BlocProvider.of<TopRatedBloc>(context);
    final item = bloc.state.listTopRated[index];
    String? title = item.title ?? '';
    String? posterPath = item.posterPath;
    double voteAverage = double.parse(item.voteAverage?.toStringAsFixed(1) ?? '');
    return SenaryItemList(
      title: title,
      rank: '${index + 1}',
      voteAverage: '$voteAverage',
      initialRating: voteAverage,
      imageUrl: '${AppConstants.kImagePathPoster}$posterPath',
      watchList: bloc.state.listMovieState[index].watchlist,
      onTapBanner: () => !(bloc.state.listMovieState[index].watchlist ?? false)
          ? bloc.add(AddWatchList(
              accountId: 11429392,
              sessionId: sessionId,
              mediaType: 'movie',
              mediaId: bloc.state.listTopRated[index].id ?? 0,
              watchlist: !(bloc.state.listMovieState[index].watchlist ?? false),
              index: index,
            ))
          : bloc.state is TopRatedAddWatchListSuccess
              ? null
              : showCupertinoModalPopup(
                  context: context,
                  builder: (context) => CupertinoActionSheet(
                    title: Text(
                      '$title (${item.releaseDate?.substring(0, 4)})',
                      style: TextStyle(
                        fontSize: 14.sp,
                      ),
                    ),
                    actions: [
                      CupertinoActionSheetAction(
                        isDefaultAction: false,
                        child: Text(
                          'Remove from Watchlist',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 18.sp,
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                          bloc.add(AddWatchList(
                            accountId: 11429392,
                            sessionId: sessionId,
                            mediaType: 'movie',
                            mediaId: bloc.state.listTopRated[index].id ?? 0,
                            watchlist: !(bloc.state.listMovieState[index].watchlist ?? false),
                            index: index,
                          ));
                        },
                      ),
                    ],
                    cancelButton: CupertinoActionSheetAction(
                      isDefaultAction: true,
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          color: blackColor,
                          fontSize: 18.sp,
                        ),
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                ),
      onTapItem: () {
        Navigator.of(context).push(
          CustomPageRoute(
            page: const DetailsPage(),
            begin: const Offset(1, 0),
          ),
        );
      },
    );
  }

  Widget separatorBuilder(BuildContext context, int index) => SizedBox(width: 14.w);
}
