part of 'home_bloc.dart';

abstract class HomeEvent {}

class ChangeAnimationToast extends HomeEvent {
  final double opacity;
  ChangeAnimationToast({
    required this.opacity,
  });
}

class DisplayToast extends HomeEvent {
  final bool visibility;
  final String statusMessage;

  DisplayToast({
    required this.visibility,
    required this.statusMessage,
  });
}
