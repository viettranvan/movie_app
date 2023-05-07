import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/ui/favorite/views/movie/index.dart';
import 'package:movie_app/ui/favorite/views/tv/index.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  FavoriteBloc()
      : super(FavoriteInitial(index: 0, views: [
          const MovieView(),
          const TvView(),
        ])) {
    on<ChangeTab>(_onChangeTab);
  }

  FutureOr<void> _onChangeTab(ChangeTab event, Emitter<FavoriteState> emit) {
    emit(FavoriteInitial(
      index: event.index,
      views: state.views,
    ));
  }
}
