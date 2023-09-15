import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:movie_app/models/models.dart';
import 'package:movie_app/shared_ui/shared_ui.dart';
import 'package:movie_app/ui/components/components.dart';
import 'package:movie_app/ui/pages/filter/filter_page.dart';
import 'package:movie_app/ui/pages/navigation/bloc/navigation_bloc.dart';
import 'package:movie_app/ui/pages/search/bloc/search_bloc.dart';
import 'package:movie_app/utils/app_utils/app_utils.dart';
import 'package:movie_app/utils/debouncer/debouncer.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Debouncer debouncer = Debouncer();
    return BlocProvider(
      create: (context) => SearchBloc()
        ..add(FetchData(
          query: '',
          language: 'en-US',
          mediaType: 'all',
          timeWindow: 'day',
          includeAdult: true,
        )),
      child: BlocListener<NavigationBloc, NavigationState>(
        listener: (context, state) =>
            state is NavigationSuccess && state.indexPage == 2 ? fetchTrending(context) : null,
        child: Scaffold(
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
          body: BlocBuilder<SearchBloc, SearchState>(
            builder: (context, state) {
              final bloc = BlocProvider.of<SearchBloc>(context);
              return NotificationListener<UserScrollNotification>(
                onNotification: (notification) {
                  final scrollDirection = bloc.scrollController.position.userScrollDirection;
                  if (scrollDirection == ScrollDirection.forward) {
                    showNavigationBar(context);
                    return false;
                  }
                  if (scrollDirection == ScrollDirection.reverse) {
                    hideNavigationBar(context);
                    return false;
                  }
                  return false;
                },
                child: Stack(
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: 88.h),
                        Expanded(
                          child: Stack(
                            children: [
                              NotificationListener<ScrollNotification>(
                                onNotification: state.visible
                                    ? (notification) {
                                        if (bloc.scrollController.hasClients &&
                                            bloc.scrollController.offset <= 2000) {
                                          hideButton(context);
                                          return false;
                                        }
                                        return false;
                                      }
                                    : (notification) {
                                        if (bloc.scrollController.hasClients &&
                                            bloc.scrollController.offset > 2000) {
                                          showButton(context);
                                          return false;
                                        }
                                        return false;
                                      },
                                child: BlocBuilder<SearchBloc, SearchState>(
                                  builder: (context, state) {
                                    if (state is SearchInitial) {
                                      return const Center(
                                        child: CustomIndicator(
                                          radius: 10,
                                        ),
                                      );
                                    }
                                    if (state is SearchError) {
                                      return Center(
                                        child: Text(
                                          state.errorMessage,
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                          ),
                                        ),
                                      );
                                    }
                                    return SmartRefresher(
                                      scrollController: bloc.scrollController,
                                      controller: bloc.refreshController,
                                      enablePullUp: enablePullUp(
                                          state.listSearch, state.listTrending, context),
                                      enablePullDown: enablePullUp(
                                          state.listSearch, state.listTrending, context),
                                      header: const Header(),
                                      footer: Footer(
                                        height: 140.h,
                                        noMoreStatus: 'All results was loaded !',
                                        failedStatus: 'Failed to load results !',
                                      ),
                                      onRefresh: () => fetchSearch(context, state.query),
                                      onLoading: () => loadMore(context, state.query),
                                      child: MasonryGridView.count(
                                        addAutomaticKeepAlives: false,
                                        addRepaintBoundaries: false,
                                        padding: EdgeInsets.fromLTRB(20.w, 5.h, 20.w, 0),
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 16,
                                        mainAxisSpacing: 16,
                                        shrinkWrap: true,
                                        itemBuilder: itemBuilder,
                                        itemCount: state.listSearch.isNotEmpty
                                            ? state.listSearch.length
                                            : state.listTrending.length,
                                      ),
                                    );
                                  },
                                ),
                              ),
                              CustomScrollButton(
                                visible: state.visible,
                                opacity: state.visible ? 1.0 : 0.0,
                                onTap: state.visible ? () => scrollToTop(context) : null,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      color: darkWhiteColor,
                      child: CustomTextField(
                        controller: bloc.textController,
                        hintText: 'Search for movies, tv shows, people...'.padLeft(14),
                        onTapFilter: () => goToFilterPage(context),
                        suffixIcon: bloc.textController.text.isNotEmpty
                            ? IconButton(
                                onPressed: () => fetchTrending(context),
                                icon: Icon(
                                  Icons.cancel_rounded,
                                  color: lightGreyColor,
                                ),
                              )
                            : null,
                        onChanged: (value) {
                          bloc.add(LoadShimmer());
                          debouncer.call(() => fetchSearch(context, value));
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
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

  bool enablePullUp(
      List<MultipleMedia> listSearch, List<MultipleMedia> listTrending, BuildContext context) {
    final state = BlocProvider.of<SearchBloc>(context).state;
    if (state is SearchError) {
      return false;
    } else if (state is SearchSuccess) {
      return true;
    } else {
      return false;
    }
  }

  fetchSearch(BuildContext context, String query) {
    final bloc = BlocProvider.of<SearchBloc>(context);
    bloc.add(FetchData(
      query: query,
      includeAdult: true,
      language: 'en-US',
      mediaType: 'all',
      timeWindow: 'day',
    ));
  }

  loadMore(BuildContext context, String query) => BlocProvider.of<SearchBloc>(context).add(
        LoadMore(
          query: query,
          includeAdult: true,
          language: 'en-US',
          mediaType: 'all',
          timeWindow: 'day',
        ),
      );

  fetchTrending(BuildContext context) {
    final bloc = BlocProvider.of<SearchBloc>(context);
    bloc.textController.clear();
    bloc.add(ScrollToTop());
    fetchSearch(context, '');
  }

  bool showButton(BuildContext context) {
    BlocProvider.of<SearchBloc>(context).add(ShowHideButton(visible: true));
    return true;
  }

  bool hideButton(BuildContext context) {
    BlocProvider.of<SearchBloc>(context).add(ShowHideButton(visible: false));
    return true;
  }

  scrollToTop(BuildContext context) {
    final bloc = BlocProvider.of<SearchBloc>(context);
    final navigationBloc = BlocProvider.of<NavigationBloc>(context);
    showIndicator(context);
    Future.delayed(
      const Duration(milliseconds: 1000),
      () {
        Navigator.of(context).pop();
        bloc.add(ScrollToTop());
        fetchSearch(context, bloc.state.query);
        navigationBloc.add(ShowHide(visible: true));
      },
    );
  }

  goToFilterPage(BuildContext context) {
    showNavigationBar(context);
    fetchTrending(context);
    Navigator.of(context).push(
      CustomPageRoute(
        page: const FilterPage(),
        begin: const Offset(1, 0),
      ),
    );
  }

  showIndicator(BuildContext context) => AppUtils().showCustomDialog(
        context: context,
        alignment: const Alignment(0, 0.2),
        child: const CustomIndicator(
          radius: 15,
        ),
      );

  showNavigationBar(BuildContext context) =>
      BlocProvider.of<NavigationBloc>(context).add(ShowHide(visible: true));

  hideNavigationBar(BuildContext context) =>
      BlocProvider.of<NavigationBloc>(context).add(ShowHide(visible: false));
}
