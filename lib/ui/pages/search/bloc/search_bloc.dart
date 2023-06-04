import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/models/models.dart';
import 'package:movie_app/ui/pages/home/home_repository.dart';
import 'package:movie_app/ui/pages/search/index.dart';
import 'package:movie_app/utils/utils.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchRepository searchRepository = SearchRepository(restApiClient: RestApiClient());
  HomeRepository homeRepository = HomeRepository(restApiClient: RestApiClient());
  RefreshController refreshController = RefreshController();
  TextEditingController textController = TextEditingController();
  ScrollController scrollController = ScrollController();
  int page = 1;
  bool visible = false;
  SearchBloc()
      : super(SearchInitial(
          query: '',
          listSearch: [],
          listTrending: [],
        )) {
    on<FetchData>(_onFetchData);
    on<LoadMore>(_onLoadMore);
    on<ScrollToTop>(_onScrollToTop);
    on<ShowHideButton>(_onShowHideButton);
  }

  FutureOr<void> _onFetchData(FetchData event, Emitter<SearchState> emit) async {
    try {
      page = 1;
      final searchResult = await searchRepository.searchMultipleMedia(
        query: event.query,
        includeAdult: event.includeAdult,
        language: event.language,
        page: page,
      );
      if (searchResult.list.isNotEmpty) {
        page++;
        emit(SearchSuccess(
          listSearch: searchResult.list,
          query: event.query,
          listTrending: state.listTrending,
        ));
      } else {
        page = 1;
        final trendingResult = await homeRepository.getTrendingMovie(
          mediaType: event.mediaType,
          timeWindow: event.timeWindow,
          page: page,
          language: event.language,
          includeAdult: event.includeAdult,
        );
        if (trendingResult.list.isNotEmpty) {
          state.listSearch.clear();
          page++;
          emit(SearchSuccess(
            listSearch: state.listSearch,
            query: event.query,
            listTrending: trendingResult.list,
          ));
        } else {
          emit(SearchSuccess(
            listSearch: state.listSearch,
            query: event.query,
            listTrending: trendingResult.list,
          ));
        }
      }
      refreshController.loadComplete();
      refreshController.refreshCompleted();
    } catch (e) {
      refreshController.refreshFailed();
      emit(SearchError(
        errorMessage: e.toString(),
        listSearch: state.listSearch,
        listTrending: state.listTrending,
        query: state.query,
      ));
    }
  }

  FutureOr<void> _onLoadMore(LoadMore event, Emitter<SearchState> emit) async {
    try {
      refreshController.requestLoading();
      if (page > 1000) {
        refreshController.loadNoData();
        return;
      }
      var currentSearchList = (state as SearchSuccess).listSearch;
      if (currentSearchList.isNotEmpty) {
        final searchResult = await searchRepository.searchMultipleMedia(
          query: event.query,
          includeAdult: event.includeAdult,
          language: event.language,
          page: page,
        );
        if (searchResult.list.isEmpty) {
          refreshController.loadNoData();
        } else {
          page++;
          var newList = List<MultipleMedia>.from(currentSearchList)..addAll(searchResult.list);
          emit(SearchSuccess(
            listSearch: newList,
            listTrending: state.listTrending,
            query: event.query,
          ));
          refreshController.loadComplete();
        }
      } else {
        var currentTrendingList = (state as SearchSuccess).listTrending;
        final trendingResult = await homeRepository.getTrendingMovie(
          mediaType: event.mediaType,
          timeWindow: event.timeWindow,
          page: page,
          language: event.language,
          includeAdult: event.includeAdult,
        );
        if (trendingResult.list.isEmpty) {
          refreshController.loadNoData();
        } else {
          page++;
          var newList = List<MultipleMedia>.from(currentTrendingList)..addAll(trendingResult.list);
          emit(SearchSuccess(
            listSearch: state.listSearch,
            listTrending: newList,
            query: state.query,
          ));
          refreshController.loadComplete();
        }
      }
    } catch (e) {
      refreshController.loadFailed();
      emit(SearchError(
        errorMessage: e.toString(),
        listSearch: state.listSearch,
        listTrending: state.listTrending,
        query: state.query,
      ));
    }
  }

  FutureOr<void> _onScrollToTop(ScrollToTop event, Emitter<SearchState> emit) {
    scrollController.jumpTo(
      scrollController.position.minScrollExtent,
    );
    emit(SearchSuccess(
      listSearch: state.listSearch,
      listTrending: state.listTrending,
      query: state.query,
    ));
  }

  FutureOr<void> _onShowHideButton(ShowHideButton event, Emitter<SearchState> emit) {
    if (state.listTrending.isNotEmpty) {
      scrollController.addListener(() {
        scrollController.offset > 900 ? visible = true : visible = false;
      });
      emit(SearchSuccess(
        listSearch: state.listSearch,
        listTrending: state.listTrending,
        query: state.query,
      ));
    } else {
      emit(SearchError(
        errorMessage: 'An unexpected error occurred.',
        listSearch: state.listSearch,
        listTrending: state.listTrending,
        query: state.query,
      ));
    }
  }
}
