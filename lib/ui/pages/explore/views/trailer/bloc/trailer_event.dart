// ignore_for_file: public_member_api_docs, sort_constructors_first
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

class ShowMovieVideo extends TrailerEvent {
  final int? currentIndexMovie;
  final int? currentIndexTv;
  final List<bool> visibleVideoMovie;
  final List<bool> visibleVideoTv;

  ShowMovieVideo({
    this.currentIndexMovie,
    this.currentIndexTv,
    required this.visibleVideoMovie,
    required this.visibleVideoTv,
  });
}

class PlayTrailer extends TrailerEvent {
  final int? currentIndexMovie;
  final int? currentIndexTv;
  final String trailerKey;
  PlayTrailer({
    this.currentIndexMovie,
    this.currentIndexTv,
    required this.trailerKey,
  });
}
