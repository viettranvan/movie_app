part of 'search_bloc.dart';

abstract class SearchState {
  final List<MultipleMedia> listSearch;
  final List<MultipleMedia> listTrending;
  final String query;
  SearchState({
    required this.listSearch,
    required this.listTrending,
    required this.query,
  });
}

class SearchInitial extends SearchState {
  SearchInitial({
    required super.listSearch,
    required super.query,
    required super.listTrending,
  });
}

class SearchSuccess extends SearchState {
  SearchSuccess({
    required super.listSearch,
    required super.query,
    required super.listTrending,

  });
}

class SearchError extends SearchState {
  final String errorMessage;
  SearchError({
    required this.errorMessage,
    required super.listSearch,
    required super.listTrending,
    required super.query,

  });
}
