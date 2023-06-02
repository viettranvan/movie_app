part of 'genre_bloc.dart';

abstract class GenreEvent {}

class FetchData extends GenreEvent {
  final String language;
  FetchData({
    required this.language,
  });
}

class SwitchType extends GenreEvent {
  final bool isActive;
  SwitchType({
    required this.isActive,
  });
}

