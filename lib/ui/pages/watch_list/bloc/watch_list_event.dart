part of 'watch_list_bloc.dart';

abstract class WatchListEvent {}

class ChangeTab extends WatchListEvent {
  final int index;
  ChangeTab({
    required this.index,
  });
}