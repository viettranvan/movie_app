import 'dart:async';
import 'dart:developer';

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
  ScrollController scrollController = ScrollController(debugLabel: 'Scroll');
  int page = 1;
  int pageTrending = 1;
  bool visible = false;
  SearchBloc()
      : super(SearchInitial(
          query: '',
          listSearch: [],
          listTrending: [],
        )) {
    on<FetchTrending>(_onFetchTrending);
    on<LoadMoreTrending>(_onLoadMoreTrending);
    on<FetchSearch>(_onFetchSearch);
    on<LoadMoreSearch>(_onLoadMoreSearch);
    on<ScrollToTop>(_onScrollToTop);
    on<ShowHideButton>(_onShowHideButton);
  }

  FutureOr<void> _onFetchTrending(FetchTrending event, Emitter<SearchState> emit) async {
    try {
      add(ScrollToTop());
      pageTrending = 1;
      final trendingResult = await homeRepository.getTrendingMovie(
        mediaType: event.mediaType,
        timeWindow: event.timeWindow,
        page: pageTrending,
        language: event.language,
        includeAdult: event.includeAdult,
      );
      if (trendingResult.list.isNotEmpty) {
        pageTrending++;
        emit(SearchSuccess(
          listSearch: state.listSearch,
          query: state.query,
          listTrending: trendingResult.list,
        ));
      } else {
        emit(SearchSuccess(
          listSearch: state.listSearch,
          query: state.query,
          listTrending: trendingResult.list,
        ));
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

  FutureOr<void> _onLoadMoreTrending(LoadMoreTrending event, Emitter<SearchState> emit) async {
    try {
      if (pageTrending > 1000) {
        refreshController.loadNoData();
        return;
      }
      var currentTrendingList = (state as SearchSuccess).listTrending;
      final trendingResult = await homeRepository.getTrendingMovie(
        mediaType: event.mediaType,
        timeWindow: event.timeWindow,
        page: pageTrending,
        language: event.language,
        includeAdult: event.includeAdult,
      );
      if (trendingResult.list.isEmpty) {
        refreshController.loadNoData();
      } else {
        pageTrending++;
        var newList = List<MultipleMedia>.from(currentTrendingList)..addAll(trendingResult.list);
        emit(SearchSuccess(
          listSearch: state.listSearch,
          listTrending: newList,
          query: state.query,
        ));
        refreshController.loadComplete();
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
    log(page.toString());
  }

  FutureOr<void> _onFetchSearch(FetchSearch event, Emitter<SearchState> emit) async {
    try {
      add(ScrollToTop());
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
        emit(SearchSuccess(
          listSearch: searchResult.list,
          query: event.query,
          listTrending: state.listTrending,
        ));
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

  FutureOr<void> _onLoadMoreSearch(LoadMoreSearch event, Emitter<SearchState> emit) async {
    try {
      refreshController.requestLoading();
      var currentSearchList = (state as SearchSuccess).listSearch;
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
    scrollController.jumpTo(0);
    emit(SearchSuccess(
      listSearch: state.listSearch,
      listTrending: state.listTrending,
      query: state.query,
    ));
  }

  FutureOr<void> _onShowHideButton(ShowHideButton event, Emitter<SearchState> emit) {
    scrollController.addListener(() {
      scrollController.offset > 90 ? visible = true : visible = false;
    });

    emit(SearchSuccess(
      listSearch: state.listSearch,
      listTrending: state.listTrending,
      query: state.query,
    ));
  }
}
