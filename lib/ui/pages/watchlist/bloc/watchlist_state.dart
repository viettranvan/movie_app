part of 'watchlist_bloc.dart';

abstract class WatchlistState {
  final int index;
  WatchlistState({
    required this.index,
  });
}

class WatchlistInitial extends WatchlistState {
  WatchlistInitial({
    required super.index,
  });
}
