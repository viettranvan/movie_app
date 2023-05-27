part of 'artist_bloc.dart';

abstract class ArtistState {
  final List<MultipleMedia> listArtist;
  ArtistState({
    required this.listArtist,
  });
}

class ArtistInitial extends ArtistState {
  ArtistInitial({required super.listArtist});
}

class ArtistSuccess extends ArtistState {
  ArtistSuccess({required super.listArtist});
}

class ArtistError extends ArtistState {
  final String errorMessage;
  ArtistError({
    required this.errorMessage,
    required super.listArtist,
  });
}
