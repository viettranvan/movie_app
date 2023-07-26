part of 'movie_bloc.dart';

abstract class MovieState {
  final List<MultipleMedia> listWatchList;
  final List<String> listSort = const ['created_at.desc', 'created_at.asc'];
  final bool isDropDown;
  final int indexSelected;
  final String sortBy;
  MovieState({
    required this.listWatchList,
    required this.isDropDown,
    required this.indexSelected,
    required this.sortBy,
  });
}

class MovieInitial extends MovieState {
  MovieInitial({
    required super.listWatchList,
    required super.isDropDown,
    required super.indexSelected,
    required super.sortBy,
  });
}

class MovieSuccess extends MovieState {
  MovieSuccess({
    required super.listWatchList,
    required super.isDropDown,
    required super.indexSelected,
    required super.sortBy,
  });
}

class MovieSortSuccess extends MovieState {
  MovieSortSuccess({
    required super.listWatchList,
    required super.isDropDown,
    required super.indexSelected,
    required super.sortBy,
  });
}

class MovieError extends MovieState {
  final String errorMessage;
  MovieError({
    required this.errorMessage,
    required super.listWatchList,
    required super.isDropDown,
    required super.indexSelected,
    required super.sortBy,
  });
}
