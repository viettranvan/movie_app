part of 'watchlist_movie_bloc.dart';

abstract class WatchlistMovieEvent {}

class FetchData extends WatchlistMovieEvent {
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

class LoadMore extends WatchlistMovieEvent {
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

class Sort extends WatchlistMovieEvent {
  final String sortBy;
  bool status;
  Sort({
    required this.status,
    required this.sortBy,
  });
}

class LoadShimmer extends WatchlistMovieEvent {}
