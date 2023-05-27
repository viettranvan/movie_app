part of 'search_bloc.dart';

abstract class SearchEvent {}

class FetchData extends SearchEvent {
  final String query;
  final bool includeAdult;
  final String language;
  final int? page;
  FetchData({
    required this.query,
    required this.includeAdult,
    required this.language,
    this.page,
  });
}
