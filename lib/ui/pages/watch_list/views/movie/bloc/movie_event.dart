part of 'movie_bloc.dart';

abstract class MovieEvent {}

class FetchData extends MovieEvent {
  final String language;
  final int accountId;
  final String sessionId;
  String? sortBy;
  FetchData({
    required this.language,
    required this.accountId,
    required this.sessionId,
    this.sortBy,
  });
}

class LoadMore extends MovieEvent {
  final String language;
  final int accountId;
  final String sessionId;
  String? sortBy;

  LoadMore({
    required this.language,
    required this.accountId,
    required this.sessionId,
    this.sortBy,
  });
}

class DropDown extends MovieEvent {
  bool isDropDown;
  DropDown({
    required this.isDropDown,
  });
}

class Sort extends MovieEvent {
  final String sortBy;
  final int index;
  Sort({
    required this.sortBy,
    required this.index,
  });
}

class LoadShimmer extends MovieEvent {}