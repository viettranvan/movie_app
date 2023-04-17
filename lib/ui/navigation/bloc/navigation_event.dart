part of 'navigation_bloc.dart';

abstract class NavigationEvent {}

class NavigateScreen extends NavigationEvent {
  int indexPage = 0;
  NavigateScreen({
    required this.indexPage,
  });
}
