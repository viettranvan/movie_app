part of 'trailer_bloc.dart';

abstract class TrailerEvent {}

class FetchData extends TrailerEvent {
  final String language;
  final int page;
  final String region;
  final String? includeVideoLanguage;
  FetchData({
    required this.language,
    required this.page,
    required this.region,
    this.includeVideoLanguage,
  });
}

class SwitchType extends TrailerEvent {
  final bool isActive;
  SwitchType({
    required this.isActive,
  });
}

class PlayTrailer extends TrailerEvent {
  final int? indexMovie;
  final int? indexTv;
  final List<bool> visibleVideoMovie;
  final List<bool> visibleVideoTv;

  PlayTrailer({
    this.indexMovie,
    this.indexTv,
    required this.visibleVideoMovie,
    required this.visibleVideoTv,
  });
}

class StopTrailer extends TrailerEvent {}
