import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/ui/pages/watch_list/views/movie/index.dart';

import '../../favorite/views/tv/index.dart';

part 'watch_list_event.dart';
part 'watch_list_state.dart';

class WatchListBloc extends Bloc<WatchListEvent, WatchListState> {
  WatchListBloc()
      : super(WatchListInitial(
          index: 0,
          views: [
            const MovieView(),
            const TvView(),
          ],
        )) {
    on<ChangeTab>(_onChangeTab);
  }

  FutureOr<void> _onChangeTab(ChangeTab event, Emitter<WatchListState> emit) {
    emit(WatchListInitial(
      index: event.index,
      views: state.views,
    ));
  }
}
