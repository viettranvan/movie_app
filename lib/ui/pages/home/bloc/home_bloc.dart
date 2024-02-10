import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  ScrollController scrollController = ScrollController();
  HomeBloc()
      : super(HomeInitial(
          visible: false,
          opacity: 0.0,
          statusMessage: '',
        )) {
    on<ChangeAnimationToast>(_onChangeAnimationToast);
    on<DisplayToast>(_onDisplayToast);
  }

  FutureOr<void> _onChangeAnimationToast(ChangeAnimationToast event, Emitter<HomeState> emit) {
    emit(HomeSuccess(
      visible: state.visible,
      opacity: event.opacity,
      statusMessage: state.statusMessage,
    ));
  }

  FutureOr<void> _onDisplayToast(DisplayToast event, Emitter<HomeState> emit) {
    emit(HomeSuccess(
      opacity: state.opacity,
      visible: event.visibility,
      statusMessage: event.statusMessage,
    ));
  }
}
