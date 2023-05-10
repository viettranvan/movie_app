// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'favorite_bloc.dart';

abstract class FavoriteState {
  final List<Widget> views;
  final int index;
  FavoriteState({
    required this.views,
    required this.index,
  });
}

class FavoriteInitial extends FavoriteState {
  FavoriteInitial({
    required super.index,
    required super.views,
  });
}
