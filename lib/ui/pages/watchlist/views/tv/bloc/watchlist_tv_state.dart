part of 'watchlist_tv_bloc.dart';

abstract class WatchlistTvState {
  final List<MultipleMedia> listWatchList;
  final bool status;
  final String sortBy;
  WatchlistTvState({
    required this.listWatchList,
    required this.status,
    required this.sortBy,
  });
}

class WatchlistTvInitial extends WatchlistTvState {
  WatchlistTvInitial({
    required super.listWatchList,
    required super.status,
    required super.sortBy,
  });
}

class WatchlistTvSuccess extends WatchlistTvState {
  WatchlistTvSuccess({
    required super.listWatchList,
    required super.status,
    required super.sortBy,
  });
}

class WatchlistTvSortSuccess extends WatchlistTvState {
  WatchlistTvSortSuccess({
    required super.listWatchList,
    required super.status,
    required super.sortBy,
  });
}

class WatchlistTvError extends WatchlistTvState {
  final String errorMessage;
  WatchlistTvError({
    required this.errorMessage,
    required super.listWatchList,
    required super.status,
    required super.sortBy,
  });
}
