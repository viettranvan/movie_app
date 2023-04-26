import 'dart:async';

import 'package:bloc/bloc.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  bool isActive = false;
  HomeBloc() : super(HomeInitial()) {
    on<SwitchType>(_onSwitchType);
  }

  FutureOr<void> _onSwitchType(SwitchType event, Emitter<HomeState> emit) {
    isActive = !isActive;
    emit(HomeInitial());
  }
}
