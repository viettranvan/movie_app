part of 'explore_bloc.dart';

abstract class ExploreEvent {}

class ShowStatus extends ExploreEvent {
  final String statusMessage;
  ShowStatus({
    required this.statusMessage,
  });
}

class HideStatus extends ExploreEvent {}
