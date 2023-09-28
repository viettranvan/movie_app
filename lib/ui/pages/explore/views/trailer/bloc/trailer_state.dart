part of 'trailer_bloc.dart';

abstract class TrailerState {
  final bool isActive;
  final List<MultipleMedia> listMovie;
  final List<MultipleMedia> listTv;
  final List<MediaTrailer> listTrailerMovie;
  final List<MediaTrailer> listTrailerTv;
  final List<YoutubePlayerController> movieControllers;
  final List<YoutubePlayerController> tvControllers;
  final List<bool> visibleVideoMovie;
  final List<bool> visibleVideoTv;
  int currentIndexMovie;
  int currentIndexTv;

  TrailerState({
    required this.isActive,
    required this.listMovie,
    required this.listTv,
    required this.listTrailerMovie,
    required this.listTrailerTv,
    required this.movieControllers,
    required this.tvControllers,
    required this.visibleVideoMovie,
    required this.visibleVideoTv,
    required this.currentIndexMovie,
    required this.currentIndexTv,
  });
}

class TrailerInitial extends TrailerState {
  TrailerInitial({
    required super.listMovie,
    required super.isActive,
    required super.listTv,
    required super.listTrailerMovie,
    required super.listTrailerTv,
    required super.movieControllers,
    required super.tvControllers,
    required super.visibleVideoTv,
    required super.visibleVideoMovie,
    required super.currentIndexMovie,
    required super.currentIndexTv,
  });
}

class TrailerSuccess extends TrailerState {
  TrailerSuccess({
    required super.listMovie,
    required super.isActive,
    required super.listTv,
    required super.listTrailerMovie,
    required super.listTrailerTv,
    required super.movieControllers,
    required super.tvControllers,
    required super.currentIndexMovie,
    required super.visibleVideoMovie,
    required super.visibleVideoTv,
    required super.currentIndexTv,
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
    required super.movieControllers,
    required super.tvControllers,
    required super.currentIndexMovie,
    required super.visibleVideoMovie,
    required super.visibleVideoTv,
    required super.currentIndexTv,
  });
}
