part of 'watchlist_tv_bloc.dart';

abstract class WatchlistTvEvent {}

class FetchData extends WatchlistTvEvent {
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

class LoadMore extends WatchlistTvEvent {
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


class Sort extends WatchlistTvEvent {
  bool status;

  final String sortBy;
  Sort({
    required this.sortBy,
    required this.status,

  });
}

class LoadShimmer extends WatchlistTvEvent {}