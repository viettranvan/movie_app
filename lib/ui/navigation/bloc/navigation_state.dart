// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'navigation_bloc.dart';

abstract class NavigationState {
  final List<StatelessWidget> pages;
  NavigationState({
    required this.pages,
  });
}

class NavigationInitial extends NavigationState {
  NavigationInitial({required super.pages});
}
