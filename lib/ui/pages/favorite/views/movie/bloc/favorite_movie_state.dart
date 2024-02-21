part of 'favorite_movie_bloc.dart';

abstract class FavoriteMovieState {
  final List<MultipleMedia> listFavorite;
  final bool status;
  final String sortBy;
  FavoriteMovieState({
    required this.listFavorite,
    required this.status,
    required this.sortBy,
  });
}

class FavoriteMovieInitial extends FavoriteMovieState {
  FavoriteMovieInitial({
    required super.listFavorite,
    required super.status,
    required super.sortBy,
  });
}

class FavoriteMovieSuccess extends FavoriteMovieState {
  FavoriteMovieSuccess({
    required super.listFavorite,
    required super.status,
    required super.sortBy,
  });
}

class FavoriteMovieSortSuccess extends FavoriteMovieState {
  FavoriteMovieSortSuccess({
    required super.listFavorite,
    required super.status,
    required super.sortBy,
  });
}

class FavoriteMovieError extends FavoriteMovieState {
  final String errorMessage;
  FavoriteMovieError({
    required this.errorMessage,
    required super.listFavorite,
    required super.status,
    required super.sortBy,
  });
}

// part of 'movie_bloc.dart';

// abstract class MovieState {
//   final List<MediaSynthesis> listFavorite;
//   final List<String> listSort = const [ 'created_at.asc', 'created_at.desc'];
//   final bool isDropDown;
//   final int indexSelected;
//   final String itemSelected;
//   String sortBy;
//   int page;
//   MovieState({
//     required this.listFavorite,
//     required this.isDropDown,
//     required this.indexSelected,
//     required this.itemSelected,
//     required this.sortBy,
//     required this.page,
//   });
// }

// class MovieInitial extends MovieState {
//   MovieInitial({
//     required super.page,
//     required super.listFavorite,
//     required super.isDropDown,
//     required super.indexSelected,
//     required super.itemSelected,
//     required super.sortBy,
//   });
// }

// class MovieSuccess extends MovieState {
//   MovieSuccess({
//     required super.page,
//     required super.listFavorite,
//     required super.isDropDown,
//     required super.indexSelected,
//     required super.itemSelected,
//     required super.sortBy,
//   });
// }

// class MovieSortSuccess extends MovieState {
//   MovieSortSuccess({
//     required super.page,
//     required super.listFavorite,
//     required super.isDropDown,
//     required super.indexSelected,
//     required super.itemSelected,
//     required super.sortBy,
//   });
// }

// class MovieError extends MovieState {
//   final String errorMessage;
//   MovieError({
//     required super.page,
//     required this.errorMessage,
//     required super.listFavorite,
//     required super.isDropDown,
//     required super.indexSelected,
//     required super.itemSelected, required super.sortBy,
//   });
// }


