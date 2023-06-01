import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  RefreshController refreshController = RefreshController();
  HomeBloc() : super(HomeInitial(isActive: false)) {
    on<SwitchType>(_onSwitchType);
    on<RefreshData>(_onRefreshData);
  }

  FutureOr<void> _onSwitchType(SwitchType event, Emitter<HomeState> emit) {
    emit(HomeInitial(isActive: event.isActive));
  }

  FutureOr<void> _onRefreshData(RefreshData event, Emitter<HomeState> emit) {
    emit(HomeSuccess(isActive: state.isActive));
    refreshController.refreshCompleted();
  }
}
