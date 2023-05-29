import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:movie_app/shared_ui/shared_ui.dart';
import 'package:movie_app/ui/components/components.dart';
import 'package:movie_app/ui/pages/filter/filter_page.dart';
import 'package:movie_app/ui/pages/search/bloc/search_bloc.dart';
import 'package:movie_app/utils/app_utils/app_utils.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchBloc()
        ..add(FetchTrending(
          language: 'en-US',
          mediaType: 'all',
          timeWindow: 'day',
          includeAdult: true,
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
              actions: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 12, 8),
                  child: Image.asset(
                    ImagesPath.primaryShortLogo.assetName,
                    scale: 4,
                    filterQuality: FilterQuality.high,
                  ),
                ),
              ],
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomTextField(
                  controller: bloc.textController,
                  hintText: 'Search for movies, tv shows, people...'.padLeft(14),
                  onTapFilter: () {
                    bloc.textController.clear();
                    state.listSearch.clear();
                    bloc.add(FetchTrending(
                      language: 'en-US',
                      mediaType: 'all',
                      timeWindow: 'day',
                      includeAdult: true,
                    ));
                    Navigator.of(context).push(
                      CustomPageRoute(
                        page: const FilterPage(),
                        begin: const Offset(1, 0),
                      ),
                    );
                  },
                  onChanged: (value) => bloc.add(
                    FetchSearch(
                      query: value,
                      includeAdult: true,
                      language: 'en-US',
                    ),
                  ),
                ),
                Expanded(
                  child: Stack(
                    children: [
                      NotificationListener<ScrollNotification>(
                        onNotification: (notification) {
                          bloc.add(ShowHideButton());
                          return true;
                        },
                        child: SmartRefresher(
                          scrollController: bloc.scrollController,
                          controller: bloc.refreshController,
                          enablePullUp: true,
                          enablePullDown: true,
                          header: const Header(),
                          footer: const Footer(
                            height: 140,
                            loadingStatus: 'All results was loaded !',
                          ),
                          onRefresh: () => state.listSearch.isNotEmpty
                              ? bloc.add(FetchSearch(
                                  query: state.query,
                                  includeAdult: true,
                                  language: 'en-US',
                                ))
                              : bloc.add(FetchTrending(
                                  language: 'en-US',
                                  mediaType: 'all',
                                  timeWindow: 'day',
                                  includeAdult: true,
                                )),
                          onLoading: () => state.listSearch.isNotEmpty
                              ? bloc.add(LoadMoreSearch(
                                  query: state.query,
                                  includeAdult: true,
                                  language: 'en-US',
                                ))
                              : bloc.add(LoadMoreTrending(
                                  language: 'en-US',
                                  mediaType: 'all',
                                  timeWindow: 'day',
                                  includeAdult: true,
                                )),
                          child: MasonryGridView.count(
                            controller: ScrollController(),
                            padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                            crossAxisCount: 2,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                            shrinkWrap: true,
                            itemBuilder: itemBuilder,
                            itemCount: state.listSearch.isNotEmpty
                                ? state.listSearch.length
                                : state.listTrending.length,
                          ),
                        ),
                      ),
                      Visibility(
                        visible: bloc.visible,
                        child: Align(
                          alignment: const Alignment(0, -0.9),
                          child: GestureDetector(
                            onTap: () => bloc.add(ScrollToTop()),
                            child: AnimatedOpacity(
                              opacity: bloc.visible ? 1.0 : 0.0,
                              duration: const Duration(microseconds: 200),
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: whiteColor,
                                  boxShadow: [
                                    BoxShadow(
                                      color: greyColor,
                                      blurRadius: 2,
                                    ),
                                  ],
                                ),
                                child: RotatedBox(
                                  quarterTurns: 45,
                                  child: Icon(
                                    Icons.arrow_circle_left_rounded,
                                    color: darkBlueColor,
                                    size: 50,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
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
    final state = BlocProvider.of<SearchBloc>(context).state;
    final item = state.listSearch.isNotEmpty ? state.listSearch[index] : state.listTrending[index];
    return GridItem(
      title: item.title ?? item.name,
      releaseYear: AppUtils().getYearReleaseOrDepartment(
        item.releaseDate,
        item.firstAirDate,
        item.mediaType ?? '',
        item.knownForDepartment,
      ),
      imageUrl: AppUtils().getImageUrl(item.posterPath, item.profilePath),
    );
  }
}
