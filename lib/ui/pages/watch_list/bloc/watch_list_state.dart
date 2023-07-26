part of 'watch_list_bloc.dart';

abstract class WatchListState {
  final List<Widget> views;
  final int index;
  WatchListState({
    required this.views,
    required this.index,
  });
}

class WatchListInitial extends WatchListState {
  WatchListInitial({
    required super.views,
    required super.index,
  });
}
