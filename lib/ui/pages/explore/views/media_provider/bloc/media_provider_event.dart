part of 'media_provider_bloc.dart';

class MediaProviderEvent {}

class FetchData extends MediaProviderEvent {
  final String language;
  final String? watchRegion;
  FetchData({
    required this.language,
    this.watchRegion,
  });
}

class ChangeList extends MediaProviderEvent {
  final bool status;
  ChangeList({
    required this.status,
  });
}
