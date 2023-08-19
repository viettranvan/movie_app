import 'dart:async';

import 'package:bloc/bloc.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc()
      : super(
          NavigationInitial(
            visible: true,
            indexPage: 0,
          ),
        ) {
    on<NavigatePage>(_onNavigateScreen);
    on<ShowHide>(_onShowHide);
  }

  FutureOr<void> _onNavigateScreen(NavigatePage event, Emitter<NavigationState> emit) {
    emit(NavigationInitial(
      visible: state.visible,
      indexPage: event.indexPage,
    ));
  }

  FutureOr<void> _onShowHide(ShowHide event, Emitter<NavigationState> emit) {
    emit(NavigationSuccess(
      visible: event.visible,
      indexPage: state.indexPage,
    ));
  }
}
