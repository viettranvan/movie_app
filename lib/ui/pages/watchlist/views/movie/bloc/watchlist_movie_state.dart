part of 'watchlist_movie_bloc.dart';

abstract class WatchlistMovieState {
  final List<MultipleMedia> listWatchList;
  final bool status;
  final String sortBy;
  WatchlistMovieState({
    required this.listWatchList,
    required this.status,
    required this.sortBy,
  });
}

class WatchlistMovieInitial extends WatchlistMovieState {
  WatchlistMovieInitial({
    required super.listWatchList,
    required super.status,
    required super.sortBy,
  });
}

class WatchlistMovieSuccess extends WatchlistMovieState {
  WatchlistMovieSuccess({
    required super.listWatchList,
    required super.status,
    required super.sortBy,
  });
}

class WatchlistMovieSortSuccess extends WatchlistMovieState {
  WatchlistMovieSortSuccess({
    required super.listWatchList,
    required super.status,
    required super.sortBy,
  });
}

class WatchlistMovieError extends WatchlistMovieState {
  final String errorMessage;
  WatchlistMovieError({
    required this.errorMessage,
    required super.listWatchList,
    required super.status,
    required super.sortBy,
  });
}
