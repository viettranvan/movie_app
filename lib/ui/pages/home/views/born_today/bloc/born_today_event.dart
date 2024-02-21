part of 'born_today_bloc.dart';

class BornTodayEvent {}

class FetchData extends BornTodayEvent {
  // final int personId;
  int page;

  final String language;
  final String? appendToResponse;
  FetchData({
    // required this.personId,
    required this.page,
    required this.language,
    this.appendToResponse,
  });
}
