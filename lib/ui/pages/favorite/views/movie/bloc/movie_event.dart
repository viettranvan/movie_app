part of 'movie_bloc.dart';

abstract class MovieEvent {}

class FetchData extends MovieEvent {
  final String language;
  final int accountId;
  final String sessionId;
  String? sortBy;
  final int page;
  FetchData({
    required this.language,
    required this.accountId,
    required this.sessionId,
    this.sortBy,
    required this.page,
  });
}

class DropDown extends MovieEvent {
  bool isDropDown;
  DropDown({
    required this.isDropDown,
  });
}

class ChooseSort extends MovieEvent {
  final int index;
  ChooseSort({
    required this.index,
  });
}
