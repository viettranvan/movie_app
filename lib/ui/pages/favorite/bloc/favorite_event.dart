part of 'favorite_bloc.dart';

abstract class FavoriteEvent {}

class ChangeTab extends FavoriteEvent {
  final int index;
  ChangeTab({
    required this.index,
  });
}
