part of 'movie_bloc.dart';

abstract class MovieState {
  final List<MediaSynthesis> listFavorite;
  final List<String> listSort;
  final bool isDropDown;
  final int indexSelected;
  final String itemSelected;
  MovieState({
    required this.listFavorite,
    required this.listSort,
    required this.isDropDown,
    required this.indexSelected,
    required this.itemSelected,
  });
}

class MovieInitial extends MovieState {
  MovieInitial({
    required super.listFavorite,
    required super.isDropDown,
    required super.listSort,
    required super.indexSelected,
    required super.itemSelected,
  });
}

class MovieSuccess extends MovieState {
  MovieSuccess({
    required super.listFavorite,
    required super.isDropDown,
    required super.listSort,
    required super.indexSelected,
    required super.itemSelected,
  });
}

class MovieSortSuccess extends MovieState {
  MovieSortSuccess({
    required super.listFavorite,
    required super.isDropDown,
    required super.listSort,
    required super.indexSelected,
    required super.itemSelected,
  });
}

class MovieError extends MovieState {
  final String errorMessage;
  MovieError({
    required this.errorMessage,
    required super.listFavorite,
    required super.isDropDown,
    required super.listSort,
    required super.indexSelected,
    required super.itemSelected,
  });
}
