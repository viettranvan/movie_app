part of 'favorite_tv_bloc.dart';

abstract class FavoriteTvEvent {}

class FetchData extends FavoriteTvEvent {
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

class LoadMore extends FavoriteTvEvent {
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

class Sort extends FavoriteTvEvent {
  final String sortBy;
  bool status;

  Sort({
    required this.sortBy,
    required this.status,
  });
}

class LoadShimmer extends FavoriteTvEvent {}
