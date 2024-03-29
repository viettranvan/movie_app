part of 'tv_bloc.dart';

abstract class TvState {
  final List<MultipleMedia> listWatchList;
  final List<String> listSort = const ['created_at.desc', 'created_at.asc'];
  final bool isDropDown;
  final int indexSelected;
  final String sortBy;
  TvState({
    required this.listWatchList,
    required this.isDropDown,
    required this.indexSelected,
    required this.sortBy,
  });
}

class TvInitial extends TvState {
  TvInitial({
    required super.listWatchList,
    required super.isDropDown,
    required super.indexSelected,
    required super.sortBy,
  });
}

class TvSuccess extends TvState {
  TvSuccess({
    required super.listWatchList,
    required super.isDropDown,
    required super.indexSelected,
    required super.sortBy,
  });
}

class TvSortSuccess extends TvState {
  TvSortSuccess({
    required super.listWatchList,
    required super.isDropDown,
    required super.indexSelected,
    required super.sortBy,
  });
}

class TvError extends TvState {
  final String errorMessage;
  TvError({
    required this.errorMessage,
    required super.listWatchList,
    required super.isDropDown,
    required super.indexSelected,
    required super.sortBy,
  });
}
