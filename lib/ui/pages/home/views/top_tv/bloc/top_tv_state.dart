part of 'top_tv_bloc.dart';

abstract class TopTvState {
  final List<MediaSynthesis> listTopTv;
  TopTvState({
    required this.listTopTv,
  });
}

class TopTvInitial extends TopTvState {
  TopTvInitial({required super.listTopTv});
}

class TopTvSuccess extends TopTvState {
  TopTvSuccess({required super.listTopTv});
}

class TopTvError extends TopTvState {
  final String errorMessage;
  TopTvError({
    required this.errorMessage,
    required super.listTopTv,
  });
}
