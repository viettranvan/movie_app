part of 'watchlist_bloc.dart';

abstract class WatchlistEvent {}

class ChangeTab extends WatchlistEvent {
  final int index;
  ChangeTab({
    required this.index,
  });
}