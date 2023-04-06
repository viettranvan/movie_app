// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'navigation_bloc.dart';

abstract class NavigationEvent {}

class NavigateScreen extends NavigationEvent {
  final int indexPage;
  NavigateScreen({
    required this.indexPage,
  });
}
