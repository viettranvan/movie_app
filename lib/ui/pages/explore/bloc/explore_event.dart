part of 'explore_bloc.dart';

abstract class ExploreEvent {}

class ChangeAnimationToast extends ExploreEvent {
  final double opacity;
  ChangeAnimationToast({
    required this.opacity,
  });
}

class DisplayToast extends ExploreEvent {
  final bool visibility;
  final String statusMessage;

  DisplayToast({
    required this.visibility,
    required this.statusMessage,
  });
}
