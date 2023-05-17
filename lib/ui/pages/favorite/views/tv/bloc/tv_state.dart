// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'tv_bloc.dart';

abstract class TvState {
  final List<MediaSynthesis> listFavorite;
  final List<String> listSort = const ['created_at.asc', 'created_at.desc'];
  final bool isDropDown;
  final int indexSelected;
  final String sortBy;
  TvState({
    required this.listFavorite,
    required this.isDropDown,
    required this.indexSelected,
    required this.sortBy,
  });
}

class TvInitial extends TvState {
  TvInitial({
    required super.listFavorite,
    required super.isDropDown,
    required super.indexSelected,
    required super.sortBy,
  });
}

class TvSuccess extends TvState {
  TvSuccess({
    required super.listFavorite,
    required super.isDropDown,
    required super.indexSelected,
    required super.sortBy,
  });
}

class TvSortSuccess extends TvState {
  TvSortSuccess({
    required super.listFavorite,
    required super.isDropDown,
    required super.indexSelected,
    required super.sortBy,
  });
}

class TvError extends TvState {
  final String errorMessage;
  TvError({
    required this.errorMessage,
    required super.listFavorite,
    required super.isDropDown,
    required super.indexSelected,
    required super.sortBy,
  });
}
