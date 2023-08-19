part of 'favorite_bloc.dart';

abstract class FavoriteState {
  final int index;
  FavoriteState({
    required this.index,
  });
}

class FavoriteInitial extends FavoriteState {
  FavoriteInitial({
    required super.index,
  });
}
