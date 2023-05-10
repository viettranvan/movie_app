part of 'genre_bloc.dart';

abstract class GenreState {
  final List<Genre> listGenreMovie;
  final List<Genre> listGenreTv;
  final bool visibleMovie;
  final bool visibleTv;
  GenreState({
    required this.listGenreMovie,
    required this.listGenreTv,
    required this.visibleMovie,
    required this.visibleTv,
  });
}

class GenreInitial extends GenreState {
  GenreInitial({
    required super.listGenreMovie,
    required super.listGenreTv,
       required super.visibleMovie,
    required super.visibleTv,
  });
}

class GenreSuccess extends GenreState {
  GenreSuccess({
    required super.listGenreMovie,
    required super.listGenreTv,
    required super.visibleMovie,
    required super.visibleTv,
  });
}

class GenreError extends GenreState {
  final String errorMessage;
  GenreError({
    required this.errorMessage,
    required super.listGenreMovie,
    required super.listGenreTv,
      required super.visibleMovie,
    required super.visibleTv,
  });
}
