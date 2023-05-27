part of 'now_playing_bloc.dart';

abstract class NowPlayingState {
  final MultipleDetails nowPlayingTv;
  final List<Color> paletteColors;
  final double averageLuminance;

  NowPlayingState({
    required this.nowPlayingTv,
    required this.paletteColors,
    required this.averageLuminance,
  });
}

class NowPlayingInitial extends NowPlayingState {
  NowPlayingInitial({
    required super.nowPlayingTv,
    required super.paletteColors,
    required super.averageLuminance,
  });
}

class NowPlayingSuccess extends NowPlayingState {
  NowPlayingSuccess({
    required super.paletteColors,
    required super.nowPlayingTv,
    required super.averageLuminance,
  });
}

class NowPlayingError extends NowPlayingState {
  final String errorMessage;
  NowPlayingError({
    required super.paletteColors,
    required this.errorMessage,
    required super.nowPlayingTv,
    required super.averageLuminance,
  });
}
