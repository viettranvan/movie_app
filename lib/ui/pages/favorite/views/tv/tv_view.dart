import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/shared_ui/colors/colors.dart';
import 'package:movie_app/shared_ui/components/components.dart';
import 'package:movie_app/ui/pages/favorite/views/tv/bloc/tv_bloc.dart';
import 'package:movie_app/ui/pages/favorite/widgets/index.dart';
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
          if (state is TvSortSuccess) {
            BlocProvider.of<TvBloc>(context).add(FetchData(
              language: 'en-US',
              accountId: 11429392,
              sessionId: '07b646a3a72375bce723cf645026fa3bbefc6b80',
              sortBy: state.sortBy,
            ));
          }
        },
        builder: (context, state) {
          var bloc = BlocProvider.of<TvBloc>(context);
          return SmartRefresher(
            controller: bloc.controller,
            enablePullDown: true,
            enablePullUp: true,
            primary: false,
            header: const Header(),
            footer: const Footer(
              height: 70,
              loadingStatus: 'All Tv Shows was loaded',
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
                      onTapItem: state.indexSelected != index
                          ? () {
                              bloc.add(Sort(
                                index: index,
                                sortBy: state.listSort[index],
                              ));
                              state.isDropDown
                                  ? bloc.add(DropDown(isDropDown: true))
                                  : bloc.add(DropDown(isDropDown: false));
                            }
                          : null,
                    );
                  },
                ),
                ListView.separated(
                  shrinkWrap: true,
                  controller: ScrollController(),
                  padding: const EdgeInsets.fromLTRB(20, 18, 20, 0),
                  itemBuilder: itemBuilder,
                  separatorBuilder: separatorBuilder,
                  itemCount: state.listFavorite.length,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget itemBuilder(BuildContext context, int index) {
    var itemFavorite = BlocProvider.of<TvBloc>(context).state.listFavorite[index];
    return ItemMedia(
      title: itemFavorite.title ?? itemFavorite.name,
      voteAverage: itemFavorite.voteAverage?.toStringAsFixed(1) ?? 0.toStringAsFixed(1),
      releaseDate: AppUtils().formatDate(itemFavorite.firstAirDate ?? ''),
      overview: itemFavorite.overview != '' ? itemFavorite.overview : 'Coming soon',
      originalLanguage: itemFavorite.originalLanguage,
      imageUrl: itemFavorite.posterPath != null
          ? '${AppConstants.kImagePathPoster}/${itemFavorite.posterPath}'
          : 'https://nileshsupermarket.com/wp-content/uploads/2022/07/no-image.jpg',
    );
  }

  Widget separatorBuilder(BuildContext context, int index) => const SizedBox(height: 18);
}
