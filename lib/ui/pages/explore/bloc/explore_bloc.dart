import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

part 'explore_event.dart';
part 'explore_state.dart';

class ExploreBloc extends Bloc<ExploreEvent, ExploreState> {
  RefreshController refreshController = RefreshController();
  ScrollController scrollController = ScrollController();
  ExploreBloc() : super(ExploreInitial()) {
    on<RefreshData>(_onRefreshData);
    on<PlayVideo>(_onPlayVideo);
  }

  FutureOr<void> _onRefreshData(RefreshData event, Emitter<ExploreState> emit) {
    emit(ExploreSuccess());
    refreshController.refreshCompleted();
  }

  FutureOr<void> _onPlayVideo(PlayVideo event, Emitter<ExploreState> emit) {
    if (scrollController.hasClients) {
      if (scrollController.position.pixels == 0) {
        emit(ExplorePlaySuccess());
      } else {
        emit(ExploreStopSuccess());
      }
    }
  }

}
