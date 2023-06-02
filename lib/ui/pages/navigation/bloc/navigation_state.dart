part of 'navigation_bloc.dart';

abstract class NavigationState {
  final List<Widget> pages;
  final int indexPage;
  NavigationState({
    required this.pages,
    required this.indexPage,
  });
}

class NavigationInitial extends NavigationState {
  NavigationInitial({
    required super.pages,
    required super.indexPage,
  });
}

