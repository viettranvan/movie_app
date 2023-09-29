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
    on<ScrollTop>(_onScrollTop);
  }

  FutureOr<void> _onNavigateScreen(NavigatePage event, Emitter<NavigationState> emit) {
    emit(NavigationSuccess(
      visible: state.visible,
      indexPage: event.indexPage,
    ));
  }

  FutureOr<void> _onShowHide(ShowHide event, Emitter<NavigationState> emit) {
    emit(NavigationShowHideSuccess(
      visible: event.visible,
      indexPage: state.indexPage,
    ));
  }

  FutureOr<void> _onScrollTop(ScrollTop event, Emitter<NavigationState> emit) {
    emit(NavigationScrollSuccess(
      visible: state.visible,
      indexPage: state.indexPage,
    ));
  }
}
