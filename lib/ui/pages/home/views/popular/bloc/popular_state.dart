part of 'popular_bloc.dart';

abstract class PopularState {
  final List<MultipleMedia> listPopular;
  final int selectedIndex;

  PopularState({
    required this.listPopular,
    required this.selectedIndex,
  });
}

class PopularInitial extends PopularState {
  PopularInitial({
    required super.listPopular,
    required super.selectedIndex,
  });
}

class PopularSuccess extends PopularState {
  PopularSuccess({
    required super.listPopular,
    required super.selectedIndex,
  });
}

class PopularError extends PopularState {
  final String errorMessage;
  PopularError({
    required this.errorMessage,
    required super.listPopular,
    required super.selectedIndex,
  });
}
