part of 'home_bloc.dart';

abstract class HomeState {
  final bool isActive;
  HomeState({
    required this.isActive,
  });
}

class HomeInitial extends HomeState {
  HomeInitial({
    required super.isActive,
  });
}
