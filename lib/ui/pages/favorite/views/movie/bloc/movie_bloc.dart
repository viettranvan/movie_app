import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:movie_app/model/model.dart';
import 'package:movie_app/ui/pages/favorite/favorite_repository.dart';
import 'package:movie_app/utils/utils.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  FavoriteRepository favoriteRepository = FavoriteRepository(restApiClient: RestApiClient());
  RefreshController controller = RefreshController();
  int page = 1;
  MovieBloc()
      : super(MovieInitial(
          listFavorite: [],
          isDropDown: false,
          indexSelected: 0,
          itemSelected: 'None',
        )) {
    on<FetchData>(_onFetchData);
    on<LoadMore>(_onLoadMore);
    on<DropDown>(_onDropDown);
    on<ChooseSort>(_onChooseSort);
  }
  FutureOr<void> _onFetchData(FetchData event, Emitter<MovieState> emit) async {
    try {
      page = 1;
      final result = await favoriteRepository.getFavoriteMovie(
        language: event.language,
        accountId: event.accountId,
        sessionId: event.sessionId,
        sortBy: event.sortBy,
        page: page,
      );
      if (result.list.isNotEmpty) {
        page++;
        emit(MovieSuccess(
          listFavorite: result.list,
          isDropDown: state.isDropDown,
          indexSelected: state.indexSelected,
          itemSelected: state.itemSelected,
        ));
      } else {
        emit(MovieSuccess(
          listFavorite: result.list,
          isDropDown: state.isDropDown,
          indexSelected: state.indexSelected,
          itemSelected: state.itemSelected,
        ));
      }
      controller.refreshCompleted();
    } catch (e) {
      controller.refreshFailed();
      emit(MovieError(
        errorMessage: e.toString(),
        listFavorite: state.listFavorite,
        isDropDown: state.isDropDown,
        indexSelected: state.indexSelected,
        itemSelected: state.itemSelected,
      ));
    }
  }

  FutureOr<void> _onLoadMore(LoadMore event, Emitter<MovieState> emit) async {
    try {
      controller.requestLoading();
      final result = await favoriteRepository.getFavoriteMovie(
        language: event.language,
        accountId: event.accountId,
        sessionId: event.sessionId,
        sortBy: event.sortBy,
        page: page,
      );
      var curentList = (state as MovieSuccess).listFavorite;
      if (result.list.isEmpty) {
        controller.loadNoData();
      } else {
        page++;
        var newList = List<MediaSynthesis>.from(curentList)..addAll(result.list);
        emit(MovieSuccess(
          listFavorite: newList,
          isDropDown: state.isDropDown,
          indexSelected: state.indexSelected,
          itemSelected: state.itemSelected,
        ));
      }
      controller.loadComplete();
    } catch (e) {
      controller.loadFailed();
      emit(MovieError(
        errorMessage: e.toString(),
        listFavorite: state.listFavorite,
        isDropDown: state.isDropDown,
        indexSelected: state.indexSelected,
        itemSelected: state.itemSelected,
      ));
    }
  }

  FutureOr<void> _onDropDown(DropDown event, Emitter<MovieState> emit) {
    emit(MovieSuccess(
      listFavorite: state.listFavorite,
      isDropDown: !event.isDropDown,
      indexSelected: state.indexSelected,
      itemSelected: state.itemSelected,
    ));
  }

  FutureOr<void> _onChooseSort(ChooseSort event, Emitter<MovieState> emit) {
    page = 1;
    emit(MovieSortSuccess(
      listFavorite: state.listFavorite,
      isDropDown: state.isDropDown,
      indexSelected: event.index,
      itemSelected: state.listSort[event.index],
    ));
  }
}


/*



 


 */