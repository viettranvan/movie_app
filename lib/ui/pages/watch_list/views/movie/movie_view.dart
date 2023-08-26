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
    return BlocProvider(
      create: (context) => MovieBloc()
        ..add(FetchData(
          language: 'en-US',
          accountId: 11429392,
          sessionId: '07b646a3a72375bce723cf645026fa3bbefc6b80',
          sortBy: 'created_at.desc',
        )),
      child: BlocConsumer<MovieBloc, MovieState>(
        listener: (context, state) {
          if (state is MovieSortSuccess) {
            BlocProvider.of<MovieBloc>(context).add(FetchData(
              language: 'en-US',
              accountId: 11429392,
              sessionId: '07b646a3a72375bce723cf645026fa3bbefc6b80',
              sortBy: state.sortBy,
            ));
          }
        },
        builder: (context, state) {
          var bloc = BlocProvider.of<MovieBloc>(context);
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
              accountId: 11429392,
              sessionId: '07b646a3a72375bce723cf645026fa3bbefc6b80',
              sortBy: state.sortBy,
            )),
            onLoading: () {
              bloc.add(LoadMore(
                language: 'en-US',
                accountId: 11429392,
                sessionId: '07b646a3a72375bce723cf645026fa3bbefc6b80',
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
                      title: state.listSort[index],
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
                        child: Center(
                          child: CustomIndicator(
                            radius: 15,
                          ),
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
                    if (state.listWatchList.isEmpty) {
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
    var itemWatchList = BlocProvider.of<MovieBloc>(context).state.listWatchList[index];
    return QuaternaryItemList(
      title: itemWatchList.title ?? itemWatchList.name,
      voteAverage: itemWatchList.voteAverage?.toStringAsFixed(1) ?? 0.toStringAsFixed(1),
      releaseDate: AppUtils().formatDate(itemWatchList.releaseDate ?? ''),
      overview: itemWatchList.overview != '' ? itemWatchList.overview : 'Coming soon',
      originalLanguage: itemWatchList.originalLanguage,
      imageUrl: itemWatchList.posterPath != null
          ? '${AppConstants.kImagePathPoster}/${itemWatchList.posterPath}'
          : 'https://nileshsupermarket.com/wp-content/uploads/2022/07/no-image.jpg',
    );
  }

  Widget separatorBuilder(BuildContext context, int index) => const SizedBox(height: 18);

  sortList(BuildContext context, int index, bool isDropDown, String sortBy) {
    final bloc = BlocProvider.of<MovieBloc>(context);
    isDropDown ? bloc.add(DropDown(isDropDown: true)) : bloc.add(DropDown(isDropDown: false));
    showIndicator(context);
    Future.delayed(
      const Duration(milliseconds: 300),
      () {
        Navigator.of(context).pop();
        bloc.add(Sort(
          index: index,
          sortBy: sortBy,
        ));
      },
    );
  }

  showIndicator(BuildContext context) => AppUtils().showCustomDialog(
        context: context,
        alignment: const Alignment(0, 0.3),
        child: const CustomIndicator(
          radius: 15,
        ),
      );
}
