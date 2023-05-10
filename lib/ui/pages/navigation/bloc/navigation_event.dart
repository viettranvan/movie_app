part of 'navigation_bloc.dart';

abstract class NavigationEvent {}

class NavigatePage extends NavigationEvent {
  int indexPage = 0;
  NavigatePage({
    required this.indexPage,
  });
}
