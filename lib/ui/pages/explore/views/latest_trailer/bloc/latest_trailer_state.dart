part of 'latest_trailer_bloc.dart';

abstract class TrailerState {
  final List<MultipleMedia> listTopRated;
  TrailerState({
    required this.listTopRated,
  });
}

class TrailerInitial extends TrailerState {
  TrailerInitial({required super.listTopRated});
}

class TrailerSuccess extends TrailerState {
  TrailerSuccess({required super.listTopRated});
}

class TrailerError extends TrailerState {
  final String errorMessage;
  TrailerError({
    required this.errorMessage,
    required super.listTopRated,
  });
}
