import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/models/models.dart';
import 'package:movie_app/ui/pages/search/index.dart';
import 'package:movie_app/utils/utils.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchRepository favoriteRepository = SearchRepository(restApiClient: RestApiClient());
  RefreshController controller = RefreshController();
  TextEditingController textcontroller = TextEditingController();

  int page = 1;
  SearchBloc()
      : super(SearchInitial(
          query: '',
          listSearch: [],
        )) {
    on<FetchData>(_onFetchData);
  }

  FutureOr<void> _onFetchData(FetchData event, Emitter<SearchState> emit) async {
    page = 1;
    final result = await favoriteRepository.searchMultipleMedia(
      query: event.query,
      includeAdult: event.includeAdult,
      language: event.language,
      page: page,
    );
    if (result.list.isNotEmpty) {
      page = 1;
      page++;
      emit(SearchSuccess(
        listSearch: result.list,
        query: event.query,
      ));
    } else {
      emit(SearchSuccess(
        listSearch: result.list,
        query: event.query,
      ));
    }
    log('---$page');
    try {
      // final result = await favoriteRepository.searchMultipleMedia(
      //   query: event.query,
      //   includeAdult: event.includeAdult,
      //   language: event.language,
      //   page: page,
      // );
      // if (result.list.isNotEmpty) {
      //   page++;
      //   emit(SearchSuccess(
      //     listSearch: result.list,
      //     query: event.query,
      //   ));
      // } else {
      //   emit(SearchSuccess(
      //     listSearch: result.list,
      //     query: event.query,
      //   ));
      // }
      controller.loadComplete();
      controller.refreshCompleted();
    } catch (e) {
      emit(SearchError(
        errorMessage: e.toString(),
        listSearch: state.listSearch,
        query: state.query,
      ));
    }
  }
}
