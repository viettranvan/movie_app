import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:movie_app/shared_ui/shared_ui.dart';
import 'package:movie_app/ui/components/components.dart';
import 'package:movie_app/ui/pages/search/bloc/search_bloc.dart';
import 'package:movie_app/utils/app_utils/app_utils.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchBloc()
        ..add(FetchData(
          query: '',
          includeAdult: false,
          language: 'en-US',
        )),
      child: BlocConsumer<SearchBloc, SearchState>(
        listener: (context, state) {},
        builder: (context, state) {
          var bloc = BlocProvider.of<SearchBloc>(context);
          return Scaffold(
            backgroundColor: darkWhiteColor,
            appBar: CustomAppBar(
              leadingWidth: 0,
              centerTitle: false,
              title: const CustomAppBarTitle(
                titleAppBar: 'Search',
              ),
              paddingActions: const EdgeInsets.fromLTRB(0, 8, 12, 8),
              actions: Image.asset(
                ImagesPath.primaryShortLogo.assetName,
                scale: 4,
                filterQuality: FilterQuality.high,
              ),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomTextField(
                  controller: bloc.textcontroller,
                  hintText: 'Search for movies, tv shows, people...'.padLeft(14),
                  onChanged: (value) {
                    bloc.add(FetchData(
                      query: value,
                      includeAdult: false,
                      language: 'en-US',
                    ));
                  },
                ),
                Expanded(
                  child: SmartRefresher(
                    controller: bloc.controller,
                    enablePullUp: true,
                    enablePullDown: true,
                    header: const Header(),
                    footer: const Footer(
                      height: 140,
                    ),
                    onRefresh: () => bloc.add(FetchData(
                      query: state.query,
                      includeAdult: false,
                      language: 'en-US',
                    )),
                    onLoading: () {},
                    child: MasonryGridView.count(
                      controller: ScrollController(keepScrollOffset: false),
                      padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      shrinkWrap: true,
                      itemBuilder: itemBuilder,
                      itemCount: state.listSearch.length,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget itemBuilder(BuildContext context, int index) {
    var itemSearch = BlocProvider.of<SearchBloc>(context).state.listSearch[index];
    return GridItem(
      title: itemSearch.title ?? itemSearch.name,
      releaseYear: AppUtils().getYearReleaseOrDepartment(
        itemSearch.releaseDate,
        itemSearch.firstAirDate,
        itemSearch.mediaType ?? '',
        itemSearch.knownForDepartment,
      ),
      imageUrl: AppUtils().getImageUrl(itemSearch.posterPath, itemSearch.profilePath),
    );
  }
}





// (itemSearch.posterPath == null && itemSearch.profilePath == null)
//     ? 'https://nileshsupermarket.com/wp-content/uploads/2022/07/no-image.jpg'
//     : AppConstants.kImagePathPoster +
//         ((itemSearch.posterPath ?? itemSearch.profilePath) ?? ''));