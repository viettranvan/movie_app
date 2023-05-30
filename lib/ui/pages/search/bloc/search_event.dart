part of 'search_bloc.dart';

abstract class SearchEvent {}

class FetchData extends SearchEvent {
  final String query;
  final bool includeAdult;
  final String language;
  final String mediaType;
  final String timeWindow;
  FetchData({
    required this.query,
    required this.includeAdult,
    required this.language,
    required this.mediaType,
    required this.timeWindow,
  });
}

class LoadMore extends SearchEvent {
  final String query;
  final bool includeAdult;
  final String language;
  final String mediaType;
  final String timeWindow;
  LoadMore({
    required this.query,
    required this.includeAdult,
    required this.language,
    required this.mediaType,
    required this.timeWindow,
  });
}


class ScrollToTop extends SearchEvent {}

class ShowHideButton extends SearchEvent {}
