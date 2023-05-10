import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/shared_ui/colors/colors.dart';
import 'package:movie_app/ui/pages/favorite/views/movie/bloc/movie_bloc.dart';
import 'package:movie_app/ui/pages/favorite/widgets/index.dart';
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
          page: 1,
        )),
      child: BlocConsumer<MovieBloc, MovieState>(
        listener: (context, state) {},
        builder: (context, state) {
          var bloc = BlocProvider.of<MovieBloc>(context);
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: SmartRefresher(
                  controller: bloc.controller,
                  onRefresh: () => bloc.add(FetchData(
                    language: 'en-US',
                    accountId: 11429392,
                    sessionId: '07b646a3a72375bce723cf645026fa3bbefc6b80',
                    page: 1,
                  )),
                  onLoading: () {},
                  enablePullDown: true,
                  enablePullUp: true,
                  primary: false,
                  footer: const CustomLoadMore(
                    height: 130,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 5),
                      CustomDropDown(
                        indexSelected: state.indexSelected,
                        isDropDown: state.isDropDown,
                        items: state.listSort,
                        itemSelected: state.itemSelected,
                        onTapDropDown: () => state.isDropDown
                            ? bloc.add(DropDown(isDropDown: true))
                            : bloc.add(DropDown(isDropDown: false)),
                        itemBuilder: (context, index) {
                          return CustomDropDownItem(
                            title: state.listSort[index],
                            colorSelected:
                                state.indexSelected == index ? darkBlueColor : whiteColor,
                            colorTitle: state.indexSelected == index ? whiteColor : darkBlueColor,
                            onTapItem: () => bloc.add(ChooseSort(index: index)),
                          );
                        },
                      ),
                      ListView.separated(
                        shrinkWrap: true,
                        primary: false,
                        controller: ScrollController(),
                        padding: const EdgeInsets.fromLTRB(25, 18, 25, 0),
                        itemBuilder: itemBuilder,
                        separatorBuilder: separatorBuilder,
                        itemCount: state.listFavorite.length,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget itemBuilder(BuildContext context, int index) {
    var itemFavorite = BlocProvider.of<MovieBloc>(context).state.listFavorite[index];

    return ItemMedia(
      title: itemFavorite.title ?? itemFavorite.name,
      voteAverage: itemFavorite.voteAverage?.toStringAsFixed(1) ?? 0.toStringAsFixed(1),
      releaseDate: itemFavorite.releaseDate ?? itemFavorite.firstAirDate,
      overview: itemFavorite.overview != '' ? itemFavorite.overview : 'Coming soon',
      originalLanguage: itemFavorite.originalLanguage,
      imageUrl: itemFavorite.posterPath != null
          ? '${AppConstants.kImagePathPoster}${itemFavorite.posterPath}'
          : 'https://nileshsupermarket.com/wp-content/uploads/2022/07/no-image.jpg',
    );
  }

  Widget separatorBuilder(BuildContext context, int index) => const SizedBox(height: 18);
}
