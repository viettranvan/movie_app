part of 'now_playing_bloc.dart';

abstract class NowPlayingState {
  final MediaSynthesisDetails nowPlayingTv;
  NowPlayingState({
    required this.nowPlayingTv,
  });
}

class NowPlayingInitial extends NowPlayingState {
  NowPlayingInitial({required super.nowPlayingTv});
}

class NowPlayingSuccess extends NowPlayingState {
  NowPlayingSuccess({required super.nowPlayingTv});
}

class NowPlayingError extends NowPlayingState {
  final String errorMessage;
  NowPlayingError({
    required this.errorMessage,
    required super.nowPlayingTv,
  });
}
