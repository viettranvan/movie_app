import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:movie_app/models/models.dart';
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
          sortBy: '',
        )) {
    on<FetchData>(_onFetchData);
    on<LoadMore>(_onLoadMore);
    on<DropDown>(_onDropDown);
    on<Sort>(_onSort);
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
          sortBy: event.sortBy ?? '',
        ));
      } else {
        emit(MovieSuccess(
          listFavorite: state.listFavorite,
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
        listFavorite: state.listFavorite,
        isDropDown: state.isDropDown,
        indexSelected: state.indexSelected,
        sortBy: event.sortBy ?? '',
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
        var newList = List<MultipleMedia>.from(curentList)..addAll(result.list);
        emit(MovieSuccess(
          listFavorite: newList,
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
        listFavorite: state.listFavorite,
        isDropDown: state.isDropDown,
        indexSelected: state.indexSelected,
        sortBy: state.sortBy,
      ));
    }
  }

  FutureOr<void> _onDropDown(DropDown event, Emitter<MovieState> emit) {
    state.listFavorite.isEmpty
        ? emit(MovieError(
            errorMessage: 'An unexpected error occurred.',
            listFavorite: state.listFavorite,
            isDropDown: !event.isDropDown,
            indexSelected: state.indexSelected,
            sortBy: state.sortBy,
          ))
        : emit(MovieSuccess(
            listFavorite: state.listFavorite,
            isDropDown: !event.isDropDown,
            indexSelected: state.indexSelected,
            sortBy: state.sortBy,
          ));
  }

  FutureOr<void> _onSort(Sort event, Emitter<MovieState> emit) {
    controller.loadComplete();
    emit(MovieSortSuccess(
      listFavorite: state.listFavorite,
      isDropDown: state.isDropDown,
      indexSelected: event.index,
      sortBy: event.sortBy,
    ));
  }
}

// import 'dart:async';
// import 'dart:developer';

// import 'package:bloc/bloc.dart';
// import 'package:movie_app/model/model.dart';
// import 'package:movie_app/ui/pages/favorite/favorite_repository.dart';
// import 'package:movie_app/utils/utils.dart';
// import 'package:pull_to_refresh/pull_to_refresh.dart';

// part 'movie_event.dart';
// part 'movie_state.dart';

// class MovieBloc extends Bloc<MovieEvent, MovieState> {
//   FavoriteRepository favoriteRepository = FavoriteRepository(restApiClient: RestApiClient());
//   RefreshController controller = RefreshController();
//   MovieBloc()
//       : super(MovieInitial(
//           listFavorite: [],
//           isDropDown: false,
//           indexSelected: 0,
//           itemSelected: 'created_at.asc',
//           page: 0,
//           sortBy: 'None',
//         )) {
//     on<FetchData>(_onFetchData);
//     on<ChooseSort>(_onChooseSort);
//   }
//   FutureOr<void> _onFetchData(FetchData event, Emitter<MovieState> emit) async {
//     try {
//       if (state is MovieInitial) {
//         final result = await favoriteRepository.getFavoriteMovie(
//           language: event.language,
//           accountId: event.accountId,
//           sessionId: event.sessionId,
//           sortBy: event.sortBy,
//           page: event.page + 1,
//         );
//         emit(MovieInitial(
//           sortBy: event.sortBy ?? '',
//           page: event.page,
//           listFavorite: result.list,
//           isDropDown: state.isDropDown,
//           indexSelected: state.indexSelected,
//           itemSelected: state.itemSelected,
//         ));
//       }
//       log('---${state.page}');
//       final nextResult = await favoriteRepository.getFavoriteMovie(
//         language: event.language,
//         accountId: event.accountId,
//         sessionId: event.sessionId,
//         sortBy: state.sortBy,
//         page: state.page++,
//       );
//       print('---${state.page}');

//       if (nextResult.list.isEmpty) {
//         controller.loadNoData();
//         return;
//       } else {
//         var list = List<MediaSynthesis>.from(state.listFavorite)..addAll(nextResult.list);
//         emit(MovieSuccess(
//           sortBy: state.sortBy,
//           page: state.page,
//           listFavorite: list,
//           isDropDown: state.isDropDown,
//           indexSelected: state.indexSelected,
//           itemSelected: state.itemSelected,
//         ));
//         controller.loadComplete();
//       }
//     } catch (e) {
//       controller.loadFailed();
//       emit(MovieError(
//         sortBy: state.sortBy,
//         page: state.page + 1,
//         errorMessage: e.toString(),
//         listFavorite: state.listFavorite,
//         isDropDown: state.isDropDown,
//         indexSelected: state.indexSelected,
//         itemSelected: state.itemSelected,
//       ));
//     }
//   }



//   FutureOr<void> _onChooseSort(ChooseSort event, Emitter<MovieState> emit) {
//     state.page = 0;
//     emit(MovieSortSuccess(
//       sortBy: state.sortBy,
//       page: state.page,
//       listFavorite: state.listFavorite,
//       isDropDown: state.isDropDown,
//       indexSelected: event.index,
//       itemSelected: state.listSort[event.index],
//     ));
//     emit(MovieInitial(
//         sortBy: state.sortBy,
//         page: state.page,
//         listFavorite: state.listFavorite,
//         isDropDown: state.isDropDown,
//         indexSelected: state.indexSelected,
//         itemSelected: state.itemSelected,
//       ));
//   }
// }
