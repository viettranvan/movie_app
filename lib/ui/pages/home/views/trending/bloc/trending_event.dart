part of 'trending_bloc.dart';

abstract class TrendingEvent {}

class FetchData extends TrendingEvent {
  final String mediaType;
  final String timeWindow;
  final int page;
  final String language;
  final bool includeAdult;

  FetchData({
    required this.mediaType,
    required this.timeWindow,
    required this.page,
    required this.language,
    required this.includeAdult,
  });
}
