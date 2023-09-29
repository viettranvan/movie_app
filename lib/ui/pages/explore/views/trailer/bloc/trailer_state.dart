part of 'trailer_bloc.dart';

abstract class TrailerState {
  final bool isActive;
  final List<MultipleMedia> listMovie;
  final List<MultipleMedia> listTv;
  final List<MediaTrailer> listTrailerMovie;
  final List<MediaTrailer> listTrailerTv;
  final List<bool> visibleVideoMovie;
  final List<bool> visibleVideoTv;

  TrailerState({
    required this.isActive,
    required this.listMovie,
    required this.listTv,
    required this.listTrailerMovie,
    required this.listTrailerTv,
    required this.visibleVideoMovie,
    required this.visibleVideoTv,
  });
}

class TrailerInitial extends TrailerState {
  TrailerInitial({
    required super.listMovie,
    required super.isActive,
    required super.listTv,
    required super.listTrailerMovie,
    required super.listTrailerTv,
    required super.visibleVideoTv,
    required super.visibleVideoMovie,
  });
}

class TrailerSuccess extends TrailerState {
  TrailerSuccess({
    required super.listMovie,
    required super.isActive,
    required super.listTv,
    required super.listTrailerMovie,
    required super.listTrailerTv,
    required super.visibleVideoMovie,
    required super.visibleVideoTv,
  });
}

class TrailerPlaySuccess extends TrailerState {
  TrailerPlaySuccess({
    required super.listMovie,
    required super.isActive,
    required super.listTv,
    required super.listTrailerMovie,
    required super.listTrailerTv,
    required super.visibleVideoMovie,
    required super.visibleVideoTv,
  });
}

class TrailerError extends TrailerState {
  final String errorMessage;
  TrailerError({
    required this.errorMessage,
    required super.listMovie,
    required super.isActive,
    required super.listTv,
    required super.listTrailerMovie,
    required super.listTrailerTv,
    required super.visibleVideoMovie,
    required super.visibleVideoTv,
  });
}
