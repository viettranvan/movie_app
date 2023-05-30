part of 'genre_bloc.dart';

abstract class GenreState {
  final List<Genre> listGenreMovie;
  final List<Genre> listGenreTv;
  GenreState({
    required this.listGenreMovie,
    required this.listGenreTv,
  });
}

class GenreInitial extends GenreState {
  GenreInitial({
    required super.listGenreMovie,
    required super.listGenreTv,
  });
}

class GenreSuccess extends GenreState {
  GenreSuccess({
    required super.listGenreMovie,
    required super.listGenreTv,
  });
}

class GenreError extends GenreState {
  final String errorMessage;
  GenreError({
    required this.errorMessage,
    required super.listGenreMovie,
    required super.listGenreTv,
  });
}
