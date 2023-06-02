import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  RefreshController refreshController = RefreshController();
  ScrollController scrollController = ScrollController();
  HomeBloc() : super(HomeInitial()) {
    on<RefreshData>(_onRefreshData);
  }

  FutureOr<void> _onRefreshData(RefreshData event, Emitter<HomeState> emit) {
    emit(HomeSuccess());
    refreshController.refreshCompleted();
  }
}
