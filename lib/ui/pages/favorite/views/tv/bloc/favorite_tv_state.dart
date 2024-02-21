part of 'favorite_tv_bloc.dart';

abstract class FavoriteTvState {
  final List<MultipleMedia> listFavorite;
  final bool status;
  final String sortBy;
  FavoriteTvState({
    required this.listFavorite,
    required this.status,
    required this.sortBy,
  });
}

class FavoriteTvInitial extends FavoriteTvState {
  FavoriteTvInitial({
    required super.listFavorite,
    required super.status,
    required super.sortBy,
  });
}

class FavoriteTvSuccess extends FavoriteTvState {
  FavoriteTvSuccess({
    required super.listFavorite,
    required super.status,
    required super.sortBy,
  });
}

class FavoriteTvSortSuccess extends FavoriteTvState {
  FavoriteTvSortSuccess({
    required super.listFavorite,
    required super.status,
    required super.sortBy,
  });
}

class FavoriteTvError extends FavoriteTvState {
  final String errorMessage;
  FavoriteTvError({
    required this.errorMessage,
    required super.listFavorite,
    required super.status,
    required super.sortBy,
  });
}
