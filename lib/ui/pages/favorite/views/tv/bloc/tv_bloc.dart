import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:movie_app/models/models.dart';
import 'package:movie_app/ui/pages/favorite/favorite_repository.dart';
import 'package:movie_app/utils/utils.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

part 'tv_event.dart';
part 'tv_state.dart';

class TvBloc extends Bloc<TvEvent, TvState> {
  FavoriteRepository favoriteRepository = FavoriteRepository(restApiClient: RestApiClient());
  RefreshController controller = RefreshController();
  int page = 1;
  TvBloc()
      : super(TvInitial(
          listFavorite: [],
          isDropDown: false,
          indexSelected: 0,
          sortBy: 'created_at.desc',
        )) {
    on<FetchData>(_onFetchData);
    on<LoadMore>(_onLoadMore);
    on<DropDown>(_onDropDown);
    on<Sort>(_onSort);
  }

  FutureOr<void> _onFetchData(FetchData event, Emitter<TvState> emit) async {
    try {
      page = 1;
      final result = await favoriteRepository.getFavoriteTv(
        language: event.language,
        accountId: event.accountId,
        sessionId: event.sessionId,
        sortBy: event.sortBy,
        page: page,
      );
      if (result.list.isNotEmpty) {
        page++;
        emit(TvSuccess(
          listFavorite: result.list,
          isDropDown: state.isDropDown,
          indexSelected: state.indexSelected,
          sortBy: event.sortBy ?? '',
        ));
      } else {
        emit(TvSuccess(
          listFavorite: result.list,
          isDropDown: state.isDropDown,
          indexSelected: state.indexSelected,
          sortBy: event.sortBy ?? '',
        ));
      }
      controller.loadComplete();
      controller.refreshCompleted();
    } catch (e) {
      controller.refreshFailed();
      emit(TvError(
        errorMessage: e.toString(),
        listFavorite: state.listFavorite,
        isDropDown: state.isDropDown,
        indexSelected: state.indexSelected,
        sortBy: event.sortBy ?? '',
      ));
    }
  }

  FutureOr<void> _onLoadMore(LoadMore event, Emitter<TvState> emit) async {
    try {
      controller.requestLoading();
      final result = await favoriteRepository.getFavoriteTv(
        language: event.language,
        accountId: event.accountId,
        sessionId: event.sessionId,
        sortBy: event.sortBy,
        page: page,
      );
      var curentList = (state as TvSuccess).listFavorite;
      if (result.list.isEmpty) {
        controller.loadNoData();
      } else {
        page++;
        var newList = List<MultipleMedia>.from(curentList)..addAll(result.list);
        emit(TvSuccess(
          listFavorite: newList,
          isDropDown: state.isDropDown,
          indexSelected: state.indexSelected,
          sortBy: state.sortBy,
        ));
        controller.loadComplete();
      }
    } catch (e) {
      controller.loadFailed();
      emit(TvError(
        errorMessage: e.toString(),
        listFavorite: state.listFavorite,
        isDropDown: state.isDropDown,
        indexSelected: state.indexSelected,
        sortBy: state.sortBy,
      ));
    }
  }

  FutureOr<void> _onDropDown(DropDown event, Emitter<TvState> emit) {
    state.listFavorite.isEmpty
        ? emit(TvError(
            errorMessage: 'An unexpected error occurred.',
            listFavorite: state.listFavorite,
            isDropDown: !event.isDropDown,
            indexSelected: state.indexSelected,
            sortBy: state.sortBy,
          ))
        : emit(TvSuccess(
            listFavorite: state.listFavorite,
            isDropDown: !event.isDropDown,
            indexSelected: state.indexSelected,
            sortBy: state.sortBy,
          ));
  }

  FutureOr<void> _onSort(Sort event, Emitter<TvState> emit) {
    controller.loadComplete();
    emit(TvSortSuccess(
      listFavorite: state.listFavorite,
      isDropDown: state.isDropDown,
      indexSelected: event.index,
      sortBy: event.sortBy,
    ));
  }
}
