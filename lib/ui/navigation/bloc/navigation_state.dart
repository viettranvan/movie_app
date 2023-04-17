part of 'navigation_bloc.dart';

abstract class NavigationState {
  final List<Widget> pages;
  final int indexPage;
  EdgeInsets margin = const EdgeInsets.fromLTRB(25, 0, 25, 23);
  EdgeInsets padding = const EdgeInsets.fromLTRB(23, 7, 23, 7);
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
