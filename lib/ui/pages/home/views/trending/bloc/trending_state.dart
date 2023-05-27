part of 'trending_bloc.dart';

abstract class TrendingState {
  final List<MultipleMedia> listTrending;
  TrendingState({
    required this.listTrending,
  });
}

class TrendingInitial extends TrendingState {
  TrendingInitial({
    required super.listTrending,
  });
}

class TrendingSuccess extends TrendingState {
  TrendingSuccess({
    required super.listTrending,
  });
}

class TrendingError extends TrendingState {
  final String errorMessage;
  TrendingError({
    required this.errorMessage,
    required super.listTrending,
  });
}
