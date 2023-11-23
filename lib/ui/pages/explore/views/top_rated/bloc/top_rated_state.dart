// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'top_rated_bloc.dart';

class TopRatedState {
  final List<MultipleMedia> listTopRated;
  TopRatedState({
    required this.listTopRated,
  });
}

class TopRatedInitial extends TopRatedState {
  TopRatedInitial({
    required super.listTopRated,
  });
}

class TopRatedSuccess extends TopRatedState {
  TopRatedSuccess({
    required super.listTopRated,
  });
}

class TopRatedError extends TopRatedState {
  final String errorMessage;

  TopRatedError({
    required this.errorMessage,
    required super.listTopRated,
  });
}
