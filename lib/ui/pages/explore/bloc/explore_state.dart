part of 'explore_bloc.dart';

abstract class ExploreState {
  final bool visible;
  final double opacity;
  final String statusMessage;
  ExploreState({
    required this.visible,
    required this.opacity,
    required this.statusMessage,
  });
}

class ExploreInitial extends ExploreState {
  ExploreInitial({
    required super.visible,
    required super.opacity,
    required super.statusMessage,
  });
}

class ExploreSuccess extends ExploreState {
  ExploreSuccess({
    required super.visible,
    required super.opacity,
    required super.statusMessage,
  });
}
