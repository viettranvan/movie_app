part of 'now_playing_bloc.dart';

abstract class NowPlayingState {
  final MediaSynthesisDetails nowPlayingTv;
  final List<Color> paletteColors;

  NowPlayingState({
    required this.nowPlayingTv,
    required this.paletteColors,
  });
}

class NowPlayingInitial extends NowPlayingState {
  NowPlayingInitial({required super.nowPlayingTv, required super.paletteColors});
}

class NowPlayingSuccess extends NowPlayingState {
  NowPlayingSuccess({
    required super.paletteColors,
    required super.nowPlayingTv,
  });
}

class NowPlayingError extends NowPlayingState {
  final String errorMessage;
  NowPlayingError({
    required super.paletteColors,

    required this.errorMessage,
    required super.nowPlayingTv,
  });
}
