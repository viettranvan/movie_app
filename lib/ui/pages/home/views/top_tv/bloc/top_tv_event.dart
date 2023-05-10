part of 'top_tv_bloc.dart';

abstract class TopTvEvent {}

class FetchData extends TopTvEvent {
  final String language;
  final int page;
  FetchData({
    required this.language,
    required this.page,
  });
}
