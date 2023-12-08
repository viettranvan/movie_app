part of 'top_rated_bloc.dart';

class TopRatedEvent {}

class FetcData extends TopRatedEvent {
  final int page;
  final String language;
  final String region;
  final String sessionId;
  FetcData({
    required this.page,
    required this.language,
    required this.region,
    required this.sessionId,
  });
}

class AddWatchList extends TopRatedEvent {
  final int accountId;
  final String sessionId;
  final String mediaType;
  final int mediaId;
   bool watchlist;
  final int index;
  AddWatchList({
    required this.accountId,
    required this.sessionId,
    required this.mediaType,
    required this.mediaId,
    required this.watchlist,
    required this.index,
  });
}
