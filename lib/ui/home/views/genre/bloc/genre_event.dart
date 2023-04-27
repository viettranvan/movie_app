part of 'genre_bloc.dart';

abstract class GenreEvent {}

class FetchData extends GenreEvent {
  final String language;
  FetchData({
    required this.language,
  });
}

class VisbleList extends GenreEvent {
  final bool visibleMovie;
  final bool visibleTv;
  VisbleList({
    required this.visibleMovie,
    required this.visibleTv,
  });
}
