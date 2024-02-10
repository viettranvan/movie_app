part of 'top_rated_bloc.dart';

class TopRatedState {
  final List<MultipleMedia> listTopRated;
  final List<MediaState> listMovieState;
  final String statusMessage;
  final int index;
  TopRatedState({
    required this.listTopRated,
    required this.listMovieState,
    required this.statusMessage,
    required this.index,
  });
}

class TopRatedInitial extends TopRatedState {
  TopRatedInitial({
    required super.listTopRated,
    required super.listMovieState,
    required super.statusMessage,
    required super.index,
  });
}

class TopRatedSuccess extends TopRatedState {
  TopRatedSuccess({
    required super.listTopRated,
    required super.listMovieState,
    required super.statusMessage,
    required super.index,
  });
}

class TopRatedAddWatchListSuccess extends TopRatedState {
  TopRatedAddWatchListSuccess({
    required super.listTopRated,
    required super.listMovieState,
    required super.statusMessage,
    required super.index,
  });
}

class TopRatedAddWatchListError extends TopRatedState {
  final String errorMessage;
  TopRatedAddWatchListError({
    required this.errorMessage,
    required super.listTopRated,
    required super.listMovieState,
    required super.statusMessage,
    required super.index,
  });
}

class TopRatedError extends TopRatedState {
  final String errorMessage;
  TopRatedError({
    required this.errorMessage,
    required super.listTopRated,
    required super.listMovieState,
    required super.statusMessage,
    required super.index,
  });
}
