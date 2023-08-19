part of 'navigation_bloc.dart';

abstract class NavigationState {
  final List<Widget> pages;
  final int indexPage;
  final bool visible;
  NavigationState({
    required this.pages,
    required this.indexPage,
    required this.visible,
  });
}

class NavigationInitial extends NavigationState {
  NavigationInitial({
    required super.pages,
    required super.indexPage,
    required super.visible,
  });
}

class NavigationSuccess extends NavigationState {
  NavigationSuccess({
    required super.pages,
    required super.indexPage,
    required super.visible,
  });
}
