import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/shared_ui/shared_ui.dart';
import 'package:movie_app/ui/components/components.dart';
import 'package:movie_app/ui/pages/watch_list/views/movie/bloc/movie_bloc.dart';
import 'package:movie_app/utils/app_utils/app_utils.dart';
import 'package:movie_app/utils/utils.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MovieView extends StatelessWidget {
  const MovieView({super.key});

  @override
  Widget build(BuildContext context) {
    String sessionId = '566e05bbb7e5ce24132f9aa1b1e2cdf3cb0bf1fb';
    int accountId = 11429392;
    return BlocProvider(
      create: (context) => MovieBloc()
        ..add(FetchData(
          language: 'en-US',
          accountId: accountId,
          sessionId: sessionId,
          sortBy: 'created_at.desc',
        )),
      child: BlocConsumer<MovieBloc, MovieState>(
        listener: (context, state) {
          final bloc = BlocProvider.of<MovieBloc>(context);
          if (state is MovieSortSuccess) {
            bloc.add(LoadShimmer());
            bloc.add(FetchData(
              language: 'en-US',
              accountId: accountId,
              sessionId: sessionId,
              sortBy: state.sortBy,
            ));
          }
        },
        builder: (context, state) {
          final bloc = BlocProvider.of<MovieBloc>(context);
          return SmartRefresher(
            controller: bloc.controller,
            enablePullDown: state.listWatchList.isNotEmpty,
            enablePullUp: state.listWatchList.isNotEmpty,
            primary: false,
            header: const Header(),
            footer: const Footer(
              height: 70,
              noMoreStatus: 'All watchlist movies was loaded !',
              failedStatus: 'Failed to load Tv Shows !',
            ),
            onRefresh: () => bloc.add(FetchData(
              language: 'en-US',
              accountId: accountId,
              sessionId: sessionId,
              sortBy: state.sortBy,
            )),
            onLoading: () {
              bloc.add(LoadMore(
                language: 'en-US',
                accountId: accountId,
                sessionId: sessionId,
                sortBy: state.sortBy,
              ));
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 5),
                CustomDropDown(
                  icon: state.isDropDown ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                  isDropDown: state.isDropDown,
                  items: state.listSort,
                  itemSelected: state.sortBy,
                  onTapDropDown: () => state.isDropDown
                      ? bloc.add(DropDown(isDropDown: true))
                      : bloc.add(DropDown(isDropDown: false)),
                  itemBuilder: (context, index) {
                    return CustomDropDownItem(
                      title: AppUtils().getSortTitle(state.listSort[index]),
                      colorSelected: state.indexSelected == index ? darkBlueColor : whiteColor,
                      colorTitle: state.indexSelected == index ? whiteColor : darkBlueColor,
                      onTapItem: state.indexSelected != index ||
                              (state.indexSelected == index && state.listWatchList.isEmpty)
                          ? () => sortList(
                                context,
                                index,
                                state.isDropDown,
                                state.listSort[index],
                              )
                          : null,
                    );
                  },
                ),
                BlocBuilder<MovieBloc, MovieState>(
                  builder: (context, state) {
                    if (state is MovieInitial) {
                      return const Expanded(
                        child: CustomIndicator(
                          radius: 15,
                        ),
                      );
                    }
                    if (state is MovieError) {
                      return Expanded(
                        child: Center(
                          child: Text(state.errorMessage),
                        ),
                      );
                    }
                    if (state is MovieSuccess && state.listWatchList.isEmpty) {
                      return CustomTextRich(
                        primaryText: 'Press',
                        secondaryText: 'to add to watchlist movies',
                        icon: Icons.bookmark,
                        color: cyanColor,
                      );
                    }
                    return ListView.separated(
                      shrinkWrap: true,
                      primary: false,
                      addAutomaticKeepAlives: false,
                      addRepaintBoundaries: false,
                      controller: ScrollController(),
                      padding: const EdgeInsets.fromLTRB(20, 18, 20, 0),
                      itemBuilder: itemBuilder,
                      separatorBuilder: separatorBuilder,
                      itemCount: state.listWatchList.length,
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget itemBuilder(BuildContext context, int index) {
    final itemWatchList = BlocProvider.of<MovieBloc>(context).state.listWatchList[index];
    return QuaternaryItemList(
      title: itemWatchList.title ?? itemWatchList.name,
      voteAverage: itemWatchList.voteAverage?.toStringAsFixed(1) ?? 0.toStringAsFixed(1),
      releaseDate: itemWatchList.releaseDate!.isNotEmpty
          ? AppUtils().formatDate(itemWatchList.releaseDate ?? '')
          : '00-00-0000',
      overview: itemWatchList.overview != '' ? itemWatchList.overview : 'Coming soon',
      originalLanguage: itemWatchList.originalLanguage,
      imageUrl: '${AppConstants.kImagePathPoster}/${itemWatchList.posterPath}',
      onTap: () {},
    );
  }

  Widget separatorBuilder(BuildContext context, int index) => const SizedBox(height: 18);

  sortList(BuildContext context, int index, bool isDropDown, String sortBy) {
    final bloc = BlocProvider.of<MovieBloc>(context);
    isDropDown ? bloc.add(DropDown(isDropDown: true)) : bloc.add(DropDown(isDropDown: false));
    bloc.add(Sort(
      index: index,
      sortBy: sortBy,
    ));
  }
}
