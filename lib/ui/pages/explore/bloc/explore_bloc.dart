import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'explore_event.dart';
part 'explore_state.dart';

class ExploreBloc extends Bloc<ExploreEvent, ExploreState> {
  ScrollController scrollController = ScrollController();
  ExploreBloc() : super(ExploreInitial()) {
    on<PlayPauseVideo>(_onPlayPauseVideo);
  }

  FutureOr<void> _onPlayPauseVideo(PlayPauseVideo event, Emitter<ExploreState> emit) {
    if (scrollController.hasClients) {
      if (scrollController.position.extentBefore <= 100) {
        emit(ExplorePlaySuccess());
      } else {
        emit(ExploreStopSuccess());
      }
    }
  }
}
