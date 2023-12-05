part of 'explore_bloc.dart';

abstract class ExploreState {
  final bool showStatus;
  final String statusMessage;
  ExploreState({
    required this.showStatus,
    required this.statusMessage,
  });
}

class ExploreInitial extends ExploreState {
  ExploreInitial({
    required super.showStatus,
    required super.statusMessage,
  });
}

class ExploreSuccess extends ExploreState {
  ExploreSuccess({
    required super.showStatus,
    required super.statusMessage,
  });
}
