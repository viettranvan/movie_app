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
                  onTapFilter: () => goToFilterPage(context),
                  onChanged: (value) => fetchSearch(context, value),
                ),
                Expanded(
                  child: Stack(
                    children: [
                      NotificationListener<ScrollNotification>(
                        onNotification: (notification) => showHideButton(context),
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
                              ? fetchSearch(context, state.query)
                              : fetchTrending(context),
                          onLoading: () => state.listSearch.isNotEmpty
                              ? loadMoreSearch(context, state.query)
                              : loadMoreTrending(context),
                          child: MasonryGridView.count(
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
                            onTap: () => scrollToTop(context),
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

  bool showHideButton(BuildContext context) {
    final bloc = BlocProvider.of<SearchBloc>(context);
    bloc.add(ShowHideButton());
    return true;
  }

  scrollToTop(BuildContext context) {
    final bloc = BlocProvider.of<SearchBloc>(context);
    final state = bloc.state;
    showIndicator(context);
    Future.delayed(
      const Duration(milliseconds: 500),
      () {
        Navigator.of(context).pop();
        bloc.add(ScrollToTop());
        state.listSearch.isNotEmpty ? fetchSearch(context, state.query) : fetchTrending(context);
      },
    );
  }

  goToFilterPage(BuildContext context) {
    final bloc = BlocProvider.of<SearchBloc>(context);
    final state = bloc.state;
    bloc.textController.clear();
    state.listSearch.clear();
    fetchTrending(context);
    Navigator.of(context).push(
      CustomPageRoute(
        page: const FilterPage(),
        begin: const Offset(1, 0),
      ),
    );
  }

  fetchTrending(BuildContext context) {
    final bloc = BlocProvider.of<SearchBloc>(context);
    bloc.add(ScrollToTop());
    bloc.add(FetchTrending(
      language: 'en-US',
      mediaType: 'all',
      timeWindow: 'day',
      includeAdult: true,
    ));
  }

  fetchSearch(BuildContext context, String query) {
    final bloc = BlocProvider.of<SearchBloc>(context);
    bloc.add(ScrollToTop());
    bloc.add(FetchSearch(
      query: query,
      includeAdult: true,
      language: 'en-US',
    ));
  }

  loadMoreTrending(BuildContext context) {
    final bloc = BlocProvider.of<SearchBloc>(context);
    bloc.add(LoadMoreTrending(
      language: 'en-US',
      mediaType: 'all',
      timeWindow: 'day',
      includeAdult: true,
    ));
  }

  loadMoreSearch(BuildContext context, String query) {
    final bloc = BlocProvider.of<SearchBloc>(context);
    bloc.add(LoadMoreSearch(
      query: query,
      includeAdult: true,
      language: 'en-US',
    ));
  }

  showIndicator(BuildContext context) => showDialog(
        barrierDismissible: false,
        barrierColor: Colors.transparent,
        useSafeArea: true,
        context: context,
        builder: (context) {
          return const Align(
            alignment: Alignment(0, 0.2),
            child: CustomIndicator(
              radius: 15,
            ),
          );
        },
      );
}
