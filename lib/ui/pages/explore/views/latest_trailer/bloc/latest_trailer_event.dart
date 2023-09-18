part of 'latest_trailer_bloc.dart';

abstract class TrailerEvent {}

class FetchData extends TrailerEvent {
  final String language;
  final int page;
  final String region;
  FetchData({
    required this.language,
    required this.page,
    required this.region,
  });
}
