part of 'navigation_bloc.dart';

abstract class NavigationState {
  final List<Widget> pages;
  final int indexPage;
  // final EdgeInsets margin = const EdgeInsets.fromLTRB(25, 0, 25, 23);
  // final EdgeInsets padding = const EdgeInsets.fromLTRB(23, 7, 23, 7);
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
