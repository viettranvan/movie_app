part of 'genre_bloc.dart';

abstract class GenreState {
  final List<Genre> listGenreMovie;
  final List<Genre> listGenreTv;
  final bool status;

  GenreState({
    required this.listGenreMovie,
    required this.listGenreTv,
    required this.status,
  });
}

class GenreInitial extends GenreState {
  GenreInitial({
    required super.listGenreMovie,
    required super.listGenreTv,
    required super.status,
  });
}

class GenreSuccess extends GenreState {
  GenreSuccess({
    required super.listGenreMovie,
    required super.listGenreTv,
    required super.status,
  });
}

class GenreError extends GenreState {
  final String errorMessage;
  GenreError({
    required this.errorMessage,
    required super.listGenreMovie,
    required super.listGenreTv,
    required super.status,
  });
}
