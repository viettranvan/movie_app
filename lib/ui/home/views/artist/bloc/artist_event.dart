part of 'artist_bloc.dart';

abstract class ArtistEvent {}

class FetchData extends ArtistEvent {
  final String language;
  final int page;
  FetchData({
    required this.language,
    required this.page,
  });
}
