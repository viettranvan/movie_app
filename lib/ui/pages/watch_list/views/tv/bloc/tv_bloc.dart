import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:movie_app/models/models.dart';
import 'package:movie_app/ui/pages/watch_list/index.dart';
import 'package:movie_app/utils/utils.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

part 'tv_event.dart';
part 'tv_state.dart';

class TvBloc extends Bloc<TvEvent, TvState> {
  WatchListRepository watchListRepository = WatchListRepository(restApiClient: RestApiClient());
  RefreshController controller = RefreshController();
  int page = 1;
  TvBloc()
      : super(TvInitial(
          listWatchList: [],
          isDropDown: false,
          indexSelected: 0,
          sortBy: 'created_at.desc',
        )) {
    on<FetchData>(_onFetchData);
    on<LoadMore>(_onLoadMore);
    on<DropDown>(_onDropDown);
    on<Sort>(_onSort);
    on<LoadShimmer>(_onLoadShimmer);
  }

  FutureOr<void> _onFetchData(FetchData event, Emitter<TvState> emit) async {
    try {
      page = 1;
      final result = await watchListRepository.getWatchListTv(
        language: event.language,
        accountId: event.accountId,
        sessionId: event.sessionId,
        sortBy: event.sortBy,
        page: page,
      );
      if (result.list.isNotEmpty) {
        page++;
        emit(TvSuccess(
          listWatchList: result.list,
          isDropDown: state.isDropDown,
          indexSelected: state.indexSelected,
          sortBy: event.sortBy ?? '',
        ));
      } else {
        emit(TvSuccess(
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
      state.listWatchList.clear();
      emit(TvError(
        errorMessage: e.toString(),
        listWatchList: state.listWatchList,
        isDropDown: state.isDropDown,
        indexSelected: state.indexSelected,
        sortBy: event.sortBy ?? '',
      ));
    }
  }

  FutureOr<void> _onLoadMore(LoadMore event, Emitter<TvState> emit) async {
    try {
      controller.requestLoading();
      final result = await watchListRepository.getWatchListTv(
        language: event.language,
        accountId: event.accountId,
        sessionId: event.sessionId,
        sortBy: event.sortBy,
        page: page,
      );
      var curentList = (state as TvSuccess).listWatchList;
      if (result.list.isEmpty) {
        controller.loadNoData();
      } else {
        page++;
        var newList = List<MultipleMedia>.from(curentList)..addAll(result.list);
        emit(TvSuccess(
          listWatchList: newList,
          isDropDown: state.isDropDown,
          indexSelected: state.indexSelected,
          sortBy: state.sortBy,
        ));
        controller.loadComplete();
      }
    } catch (e) {
      controller.loadFailed();
      state.listWatchList.clear();
      emit(TvError(
        errorMessage: e.toString(),
        listWatchList: state.listWatchList,
        isDropDown: state.isDropDown,
        indexSelected: state.indexSelected,
        sortBy: state.sortBy,
      ));
    }
  }

  FutureOr<void> _onDropDown(DropDown event, Emitter<TvState> emit) {
    state is TvError && state.listWatchList.isEmpty
        ? emit(TvError(
            errorMessage: 'An unexpected error occurred.',
            listWatchList: state.listWatchList,
            isDropDown: !event.isDropDown,
            indexSelected: state.indexSelected,
            sortBy: state.sortBy,
          ))
        : emit(TvSuccess(
            listWatchList: state.listWatchList,
            isDropDown: !event.isDropDown,
            indexSelected: state.indexSelected,
            sortBy: state.sortBy,
          ));
  }

  FutureOr<void> _onSort(Sort event, Emitter<TvState> emit) {
    controller.loadComplete();
    emit(TvSortSuccess(
      listWatchList: state.listWatchList,
      isDropDown: state.isDropDown,
      indexSelected: event.index,
      sortBy: event.sortBy,
    ));
  }

  FutureOr<void> _onLoadShimmer(LoadShimmer event, Emitter<TvState> emit) {
    emit(TvInitial(
      listWatchList: state.listWatchList,
      isDropDown: state.isDropDown,
      indexSelected: state.indexSelected,
      sortBy: state.sortBy,
    ));
  }
}
