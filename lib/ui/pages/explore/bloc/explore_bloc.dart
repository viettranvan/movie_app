// import 'dart:async';

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'explore_event.dart';
part 'explore_state.dart';

class ExploreBloc extends Bloc<ExploreEvent, ExploreState> {
  ScrollController scrollController = ScrollController();
  ExploreBloc()
      : super(ExploreInitial(
          visible: false,
          opacity: 0.0,
          statusMessage: '',
        )) {
    on<ChangeAnimationToast>(_onChangeAnimationToast);
    on<DisplayToast>(_onDisplayToast);
  }

  FutureOr<void> _onChangeAnimationToast(ChangeAnimationToast event, Emitter<ExploreState> emit) {
    emit(ExploreSuccess(
      visible: state.visible,
      opacity: event.opacity,
      statusMessage: state.statusMessage,
    ));
  }

  FutureOr<void> _onDisplayToast(DisplayToast event, Emitter<ExploreState> emit) {
    emit(ExploreSuccess(
      opacity: state.opacity,
      visible: event.visibility,
      statusMessage: event.statusMessage,
    ));
  }
}
