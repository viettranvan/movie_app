part of 'watch_list_bloc.dart';

abstract class WatchListState {
  final int index;
  WatchListState({
    required this.index,
  });
}

class WatchListInitial extends WatchListState {
  WatchListInitial({
    required super.index,
  });
}
