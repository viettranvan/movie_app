part of 'home_bloc.dart';

abstract class HomeEvent {}

class SwitchType extends HomeEvent {
  final bool isActive;
  SwitchType({
    required this.isActive,
  });
}

class RefreshData extends HomeEvent {}
