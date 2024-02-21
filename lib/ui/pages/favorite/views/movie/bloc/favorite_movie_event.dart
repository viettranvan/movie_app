part of 'favorite_movie_bloc.dart';

abstract class FavoriteMovieEvent {}

class FetchData extends FavoriteMovieEvent {
  final String language;
  final int accountId;
  final String sessionId;
  String? sortBy;
  FetchData({
    required this.language,
    required this.accountId,
    required this.sessionId,
    this.sortBy,
  });
}

class LoadMore extends FavoriteMovieEvent {
  final String language;
  final int accountId;
  final String sessionId;
  String? sortBy;

  LoadMore({
    required this.language,
    required this.accountId,
    required this.sessionId,
    this.sortBy,
  });
}

class Sort extends FavoriteMovieEvent {
  final String sortBy;
  bool status;
  Sort({
    required this.status,
    required this.sortBy,
  });
}

class LoadShimmer extends FavoriteMovieEvent {}
