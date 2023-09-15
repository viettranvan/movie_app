import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/shared_ui/colors/color.dart';
import 'package:movie_app/ui/components/components.dart';
import 'package:movie_app/ui/pages/favorite/views/tv/bloc/tv_bloc.dart';
import 'package:movie_app/utils/app_utils/app_utils.dart';
import 'package:movie_app/utils/utils.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TvView extends StatelessWidget {
  const TvView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TvBloc()
        ..add(FetchData(
          language: 'en-US',
          accountId: 11429392,
          sessionId: '07b646a3a72375bce723cf645026fa3bbefc6b80',
          sortBy: 'created_at.desc',
        )),
      child: BlocConsumer<TvBloc, TvState>(
        listener: (context, state) {
          final bloc = BlocProvider.of<TvBloc>(context);
          if (state is TvSortSuccess) {
            bloc.add(LoadShimmer());
            bloc.add(FetchData(
              language: 'en-US',
              accountId: 11429392,
              sessionId: '07b646a3a72375bce723cf645026fa3bbefc6b80',
              sortBy: state.sortBy,
            ));
          }
        },
        builder: (context, state) {
          final bloc = BlocProvider.of<TvBloc>(context);
          return SmartRefresher(
            controller: bloc.controller,
            enablePullDown: state.listFavorite.isNotEmpty,
            enablePullUp: state.listFavorite.isNotEmpty,
            primary: false,
            header: const Header(),
            footer: Footer(
              height: 70.h,
              noMoreStatus: 'All favorite tv shows was loaded !',
              failedStatus: 'Failed to load Tv Shows !',
            ),
            onRefresh: () => bloc.add(FetchData(
              language: 'en-US',
              accountId: 11429392,
              sessionId: '07b646a3a72375bce723cf645026fa3bbefc6b80',
              sortBy: state.sortBy,
            )),
            onLoading: () => bloc.add(LoadMore(
              language: 'en-US',
              accountId: 11429392,
              sessionId: '07b646a3a72375bce723cf645026fa3bbefc6b80',
              sortBy: state.sortBy,
            )),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 5.h),
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
                              (state.indexSelected == index && state.listFavorite.isEmpty)
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
                BlocBuilder<TvBloc, TvState>(
                  builder: (context, state) {
                    if (state is TvInitial) {
                      return const Expanded(
                        child: CustomIndicator(
                          radius: 15,
                        ),
                      );
                    }
                    if (state is TvError) {
                      return Expanded(
                        child: Center(
                          child: Text(state.errorMessage),
                        ),
                      );
                    }
                    if (state is TvSuccess && state.listFavorite.isEmpty) {
                      return CustomTextRich(
                        primaryText: 'Press',
                        secondaryText: 'to add to favorite tv shows',
                        icon: Icons.favorite,
                        color: pinkColor,
                      );
                    }
                    return ListView.separated(
                      shrinkWrap: true,
                      addAutomaticKeepAlives: false,
                      addRepaintBoundaries: false,
                      controller: ScrollController(keepScrollOffset: false),
                      padding: const EdgeInsets.fromLTRB(20, 18, 20, 0),
                      itemBuilder: itemBuilder,
                      separatorBuilder: separatorBuilder,
                      itemCount: state.listFavorite.length,
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
    final itemFavorite = BlocProvider.of<TvBloc>(context).state.listFavorite[index];
    return QuaternaryItemList(
      title: itemFavorite.title ?? itemFavorite.name,
      voteAverage: itemFavorite.voteAverage?.toStringAsFixed(1) ?? 0.toStringAsFixed(1),
      releaseDate: itemFavorite.firstAirDate!.isNotEmpty
          ? AppUtils().formatDate(itemFavorite.firstAirDate!)
          : '00-00-0000',
      overview: itemFavorite.overview != '' ? itemFavorite.overview : 'Coming soon',
      originalLanguage: itemFavorite.originalLanguage,
      imageUrl: itemFavorite.posterPath != null
          ? '${AppConstants.kImagePathPoster}/${itemFavorite.posterPath}'
          : 'https://nileshsupermarket.com/wp-content/uploads/2022/07/no-image.jpg',
    );
  }

  Widget separatorBuilder(BuildContext context, int index) => const SizedBox(height: 18);

  sortList(BuildContext context, int index, bool isDropDown, String sortBy) {
    final bloc = BlocProvider.of<TvBloc>(context);
    isDropDown ? bloc.add(DropDown(isDropDown: true)) : bloc.add(DropDown(isDropDown: false));
    bloc.add(Sort(
      index: index,
      sortBy: sortBy,
    ));
  }
}
