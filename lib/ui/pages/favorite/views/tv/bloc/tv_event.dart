part of 'tv_bloc.dart';

abstract class TvEvent {}

class FetchData extends TvEvent {
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

class LoadMore extends TvEvent {
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

class DropDown extends TvEvent {
  bool isDropDown;
  DropDown({
    required this.isDropDown,
  });
}

class Sort extends TvEvent {
  final String sortBy;
  final int index;
  Sort({
    required this.sortBy,
    required this.index,
  });
}

class LoadShimmer extends TvEvent {}
