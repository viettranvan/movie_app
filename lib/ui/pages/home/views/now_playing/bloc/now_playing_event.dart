part of 'now_playing_bloc.dart';

abstract class NowPlayingEvent {}

class FetchData extends NowPlayingEvent {
  final String language;
  final int page;
  FetchData({
    required this.language,
    required this.page,
  });
}

class ChangeColor extends NowPlayingEvent {
  final String posterPath;
  ChangeColor({
    required this.posterPath,
  });
}
