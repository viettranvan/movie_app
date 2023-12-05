import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'explore_event.dart';
part 'explore_state.dart';

class ExploreBloc extends Bloc<ExploreEvent, ExploreState> {
  ScrollController scrollController = ScrollController();
  ExploreBloc()
      : super(ExploreInitial(
          showStatus: false,
          statusMessage: '',
        )) {
    on<ShowStatus>(_onShowStatus);
    on<HideStatus>(_onHideStatus);
  }

  FutureOr<void> _onShowStatus(ShowStatus event, Emitter<ExploreState> emit) {
    emit(ExploreSuccess(
      showStatus: true,
      statusMessage: event.statusMessage,
    ));
  }

  FutureOr<void> _onHideStatus(HideStatus event, Emitter<ExploreState> emit) {
    emit(ExploreSuccess(
      showStatus: false,
      statusMessage: state.statusMessage,
    ));
  }
}
