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
          listSort: ['None', 'Newest', 'Oldest', 'A-Z', 'Z-A'],
          indexSelected: -1,
          itemSelected: '',
        )) {
    on<FetchData>(_onFetchData);
    on<DropDown>(_onDropDown);
    on<ChooseSort>(_onChooseSort);
  }

  FutureOr<void> _onFetchData(FetchData event, Emitter<MovieState> emit) async {
    try {
      controller.requestRefresh();
      final result = await favoriteRepository.getFavoriteMovie(
        language: event.language,
        accountId: event.accountId,
        sessionId: event.sessionId,
        page: event.page,
      );
      emit(MovieSuccess(
        listFavorite: result.list,
        isDropDown: state.isDropDown,
        listSort: state.listSort,
        indexSelected: state.indexSelected,
        itemSelected: state.itemSelected,
      ));
      controller.refreshCompleted();
    } catch (e) {
      emit(MovieError(
        errorMessage: e.toString(),
        listFavorite: state.listFavorite,
        isDropDown: state.isDropDown,
        listSort: state.listSort,
        indexSelected: state.indexSelected,
        itemSelected: state.itemSelected,
      ));
    }
  }

  FutureOr<void> _onDropDown(DropDown event, Emitter<MovieState> emit) {
    emit(MovieInitial(
      listFavorite: state.listFavorite,
      isDropDown: !event.isDropDown,
      listSort: state.listSort,
      indexSelected: state.indexSelected,
      itemSelected: state.itemSelected,
    ));
  }

  FutureOr<void> _onChooseSort(ChooseSort event, Emitter<MovieState> emit) {
    emit(MovieInitial(
      listFavorite: state.listFavorite,
      isDropDown: state.isDropDown,
      listSort: state.listSort,
      indexSelected: event.index,
      itemSelected: state.listSort[event.index],
    ));
  }
}
