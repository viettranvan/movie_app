part of 'born_today_bloc.dart';

class BornTodayState {
  final List<ArtistDetails> listArtist;
  BornTodayState({
    required this.listArtist,
  });
}

class BornTodayInitial extends BornTodayState {
  BornTodayInitial({
    required super.listArtist,
  });
}

class BornTodaySuccess extends BornTodayState {
  BornTodaySuccess({
    required super.listArtist,
  });
}

class BornTodayError extends BornTodayState {
  final String errorMessage;
  BornTodayError({
    required this.errorMessage,
    required super.listArtist,
  });
}
