part of 'best_drama_bloc.dart';

abstract class BestDramaState {
  final List<MediaSynthesis> listBestDrama;
  BestDramaState({
    required this.listBestDrama,
  });
}

class BestDramaInitial extends BestDramaState {
  BestDramaInitial({required super.listBestDrama});
}

class BestDramaSuccess extends BestDramaState {
  BestDramaSuccess({required super.listBestDrama});
}

class BestDramaError extends BestDramaState {
  final String errorMessage;
  BestDramaError({
    required this.errorMessage,
    required super.listBestDrama,
  });
}
