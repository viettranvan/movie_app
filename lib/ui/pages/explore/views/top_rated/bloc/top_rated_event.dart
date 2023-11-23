part of 'top_rated_bloc.dart';

class TopRatedEvent {}

class FetcData extends TopRatedEvent {
  final int page;
  final String language;
  final String region;
  FetcData({
    required this.page,
    required this.language,
    required this.region,
  });
}
