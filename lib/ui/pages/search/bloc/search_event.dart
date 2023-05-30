part of 'search_bloc.dart';

abstract class SearchEvent {}

class FetchSearch extends SearchEvent {
  final String query;
  final bool includeAdult;
  final String language;
  FetchSearch({
    required this.query,
    required this.includeAdult,
    required this.language,
  });
}

class FetchTrending extends SearchEvent {
  final String language;
  final String mediaType;
  final String timeWindow;
  final bool includeAdult;

  FetchTrending({
    required this.language,
    required this.mediaType,
    required this.timeWindow,
    required this.includeAdult,
  });
}

class LoadMoreSearch extends SearchEvent {
  final String query;
  final bool includeAdult;
  final String language;

  LoadMoreSearch({
    required this.query,
    required this.includeAdult,
    required this.language,
  });
}

class LoadMoreTrending extends SearchEvent {
  final String language;
  final String mediaType;
  final String timeWindow;
  final bool includeAdult;

  LoadMoreTrending({
    required this.language,
    required this.mediaType,
    required this.timeWindow,
    required this.includeAdult,
  });
}

class ScrollToTop extends SearchEvent {
 
}

class ShowHideButton extends SearchEvent {

}
