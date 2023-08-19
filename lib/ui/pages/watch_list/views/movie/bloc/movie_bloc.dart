import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:movie_app/models/models.dart';
import 'package:movie_app/ui/pages/watch_list/watch_list_repository.dart';
import 'package:movie_app/utils/utils.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  WatchListRepository watchListRepository = WatchListRepository(restApiClient: RestApiClient());
  RefreshController controller = RefreshController();
  int page = 1;
  MovieBloc()
      : super(MovieInitial(
          listWatchList: [],
          isDropDown: false,
          indexSelected: 0,
          sortBy: 'created_at.desc',
        )) {
    on<FetchData>(_onFetchData);
    on<LoadMore>(_onLoadMore);
    on<DropDown>(_onDropDown);
    on<Sort>(_onSort);
  }

  FutureOr<void> _onFetchData(FetchData event, Emitter<MovieState> emit) async {
    try {
      page = 1;
      final result = await watchListRepository.getWatchListMovie(
        language: event.language,
        accountId: event.accountId,
        sessionId: event.sessionId,
        sortBy: event.sortBy,
        page: page,
      );
      if (result.list.isNotEmpty) {
        page++;
        emit(MovieSuccess(
          listWatchList: result.list,
          isDropDown: state.isDropDown,
          indexSelected: state.indexSelected,
          sortBy: event.sortBy ?? '',
        ));
      } else {
        emit(MovieSuccess(
          listWatchList: result.list,
          isDropDown: state.isDropDown,
          indexSelected: state.indexSelected,
          sortBy: event.sortBy ?? '',
        ));
      }
      controller.loadComplete();
      controller.refreshCompleted();
    } catch (e) {
      controller.refreshFailed();
      emit(MovieError(
        errorMessage: e.toString(),
        listWatchList: state.listWatchList,
        isDropDown: state.isDropDown,
        indexSelected: state.indexSelected,
        sortBy: event.sortBy ?? '',
      ));
    }
  }

  FutureOr<void> _onLoadMore(LoadMore event, Emitter<MovieState> emit) async {
    try {
      controller.requestLoading();
      final result = await watchListRepository.getWatchListMovie(
        language: event.language,
        accountId: event.accountId,
        sessionId: event.sessionId,
        sortBy: event.sortBy,
        page: page,
      );
      var curentList = (state as MovieSuccess).listWatchList;
      if (result.list.isEmpty) {
        controller.loadNoData();
      } else {
        page++;
        var newList = List<MultipleMedia>.from(curentList)..addAll(result.list);
        emit(MovieSuccess(
          listWatchList: newList,
          isDropDown: state.isDropDown,
          indexSelected: state.indexSelected,
          sortBy: state.sortBy,
        ));
        controller.loadComplete();
      }
    } catch (e) {
      controller.loadFailed();
      emit(MovieError(
        errorMessage: e.toString(),
        listWatchList: state.listWatchList,
        isDropDown: state.isDropDown,
        indexSelected: state.indexSelected,
        sortBy: state.sortBy,
      ));
    }
  }

  FutureOr<void> _onDropDown(DropDown event, Emitter<MovieState> emit) {
    state is MovieError && state.listWatchList.isEmpty
        ? emit(MovieError(
            errorMessage: 'An unexpected error occurred.',
            listWatchList: state.listWatchList,
            isDropDown: !event.isDropDown,
            indexSelected: state.indexSelected,
            sortBy: state.sortBy,
          ))
        : emit(MovieSuccess(
            listWatchList: state.listWatchList,
            isDropDown: !event.isDropDown,
            indexSelected: state.indexSelected,
            sortBy: state.sortBy,
          ));
  }

  FutureOr<void> _onSort(Sort event, Emitter<MovieState> emit) {
    controller.loadComplete();
    emit(MovieSortSuccess(
      listWatchList: state.listWatchList,
      isDropDown: state.isDropDown,
      indexSelected: event.index,
      sortBy: event.sortBy,
    ));
  }
}
