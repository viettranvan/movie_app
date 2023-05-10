part of 'best_drama_bloc.dart';

abstract class BestDramaEvent {}

class FetchData extends BestDramaEvent {
  final String language;
  final int page;
  final List<int> withGenres;
  FetchData({
    required this.language,
    required this.page,
    required this.withGenres,
  });
}
