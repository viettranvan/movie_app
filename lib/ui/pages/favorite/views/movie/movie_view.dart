import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/shared_ui/colors/colors.dart';
import 'package:movie_app/shared_ui/components/components.dart';
import 'package:movie_app/ui/pages/favorite/views/movie/bloc/movie_bloc.dart';
import 'package:movie_app/ui/pages/favorite/widgets/index.dart';
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
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: SmartRefresher(
                  controller: bloc.controller,
                  enablePullDown: true,
                  enablePullUp: true,
                  primary: false,
                  header: const Header(),
                  footer: const Footer(
                    height: 130,
                    loadingStatus: 'All Movies was loaded',
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
                            colorSelected:
                                state.indexSelected == index ? darkBlueColor : whiteColor,
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
                        primary: false,
                        controller: ScrollController(),
                        padding: const EdgeInsets.fromLTRB(20, 18, 20, 0),
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
      releaseDate: AppUtils().formatDate(itemFavorite.releaseDate ?? ''),
      overview: itemFavorite.overview != '' ? itemFavorite.overview : 'Coming soon',
      originalLanguage: itemFavorite.originalLanguage,
      imageUrl: itemFavorite.posterPath != null
          ? '${AppConstants.kImagePathPoster}/${itemFavorite.posterPath}'
          : 'https://nileshsupermarket.com/wp-content/uploads/2022/07/no-image.jpg',
    );
  }

  Widget separatorBuilder(BuildContext context, int index) => const SizedBox(height: 18);
}

// class MovieView extends StatefulWidget {
//   const MovieView({super.key});

//   @override
//   State<MovieView> createState() => _MovieViewState();
// }

// class _MovieViewState extends State<MovieView> {
//   bool isDropDown = false;
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => MovieBloc()
//         ..add(FetchData(
//           language: 'en-US',
//           accountId: 11429392,
//           sessionId: '07b646a3a72375bce723cf645026fa3bbefc6b80',
//           page: 0,
//         )),
//       child: BlocConsumer<MovieBloc, MovieState>(
//         listener: (context, state) {
//           if (state is MovieSortSuccess) {
//             BlocProvider.of<MovieBloc>(context).add(FetchData(
//               language: 'en-US',
//               accountId: 11429392,
//               sessionId: '07b646a3a72375bce723cf645026fa3bbefc6b80',
//               page: state.page,
//               sortBy: state.itemSelected,
//               listFavorite: state.listFavorite,
//             ));
//           }
//         },
//         builder: (context, state) {
//           var bloc = BlocProvider.of<MovieBloc>(context);
//           return Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Expanded(
//                 child: SmartRefresher(
//                   controller: bloc.controller,
//                   // onRefresh: () => bloc.add(FetchData(
//                   //   language: 'en-US',
//                   //   accountId: 11429392,
//                   //   sessionId: '07b646a3a72375bce723cf645026fa3bbefc6b80',
//                   //   sortBy: state.itemSelected,
//                   //   page: 0,
//                   // )),
//                   onLoading: () {
//                     bloc.add(FetchData(
//                       language: 'en-US',
//                       accountId: 11429392,
//                       sessionId: '07b646a3a72375bce723cf645026fa3bbefc6b80',
//                       sortBy: state.itemSelected,
//                       page: state.page,
//                       listFavorite: state.listFavorite,
//                     ));
//                   },
//                   enablePullDown: true,
//                   enablePullUp: true,
//                   primary: false,
//                   footer: const CustomLoadMore(
//                     height: 130,
//                   ),
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       const SizedBox(height: 5),
//                       CustomDropDown(
//                         icon: isDropDown ? Icons.arrow_drop_up : Icons.arrow_drop_down,
//                         isDropDown: isDropDown,
//                         items: state.listSort,
//                         itemSelected: state.itemSelected,
//                         onTapDropDown: () => setState(() {
//                           isDropDown = !isDropDown;
//                         }),
//                         itemBuilder: (context, index) {
//                           return CustomDropDownItem(
//                             title: state.listSort[index],
//                             colorSelected:
//                                 state.indexSelected == index ? darkBlueColor : whiteColor,
//                             colorTitle: state.indexSelected == index ? whiteColor : darkBlueColor,
//                             onTapItem: state.indexSelected != index
//                                 ? () {
//                                     bloc.add(ChooseSort(index: index));
//                                     setState(() {
//                                       isDropDown = !isDropDown;
//                                     });
//                                   }
//                                 : null,
//                           );
//                         },
//                       ),
//                       ListView.separated(
//                         shrinkWrap: true,
//                         primary: false,
//                         controller: ScrollController(),
//                         padding: const EdgeInsets.fromLTRB(20, 18, 20, 0),
//                         itemBuilder: itemBuilder,
//                         separatorBuilder: separatorBuilder,
//                         itemCount: state.listFavorite.length,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }

//   Widget itemBuilder(BuildContext context, int index) {
//     var itemFavorite = BlocProvider.of<MovieBloc>(context).state.listFavorite[index];

//     return ItemMedia(
//       title: itemFavorite.title ?? itemFavorite.name,
//       voteAverage: itemFavorite.voteAverage?.toStringAsFixed(1) ?? 0.toStringAsFixed(1),
//       releaseDate: itemFavorite.releaseDate ?? itemFavorite.firstAirDate,
//       overview: itemFavorite.overview != '' ? itemFavorite.overview : 'Coming soon',
//       originalLanguage: itemFavorite.originalLanguage,
//       imageUrl: itemFavorite.posterPath != null
//           ? '${AppConstants.kImagePathPoster}${itemFavorite.posterPath}'
//           : 'https://nileshsupermarket.com/wp-content/uploads/2022/07/no-image.jpg',
//     );
//   }

//   Widget separatorBuilder(BuildContext context, int index) => const SizedBox(height: 18);
// }
