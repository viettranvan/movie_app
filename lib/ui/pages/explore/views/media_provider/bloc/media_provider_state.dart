part of 'media_provider_bloc.dart';

class MediaProviderState {
  List<MediaProvider> listMovieProviders;
  List<MediaProvider> listTvProviders;
  final bool status;
  MediaProviderState({
    required this.listMovieProviders,
    required this.listTvProviders,
    required this.status,
  });
}

class MediaProviderInitial extends MediaProviderState {
  MediaProviderInitial({
    required super.status,
    required super.listMovieProviders,
    required super.listTvProviders,
  });
}

class MediaProviderSuccess extends MediaProviderState {
  MediaProviderSuccess({
    required super.status,
    required super.listMovieProviders,
    required super.listTvProviders,
  });
}

class MediaProviderError extends MediaProviderState {
  final String errorMessage;
  MediaProviderError({
    required this.errorMessage,
    required super.status,
    required super.listMovieProviders,
    required super.listTvProviders,
  });
}
