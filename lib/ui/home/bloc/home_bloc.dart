import 'dart:async';

import 'package:bloc/bloc.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial(isActive: false)) {
    on<SwitchType>(_onSwitchType);
  }

  FutureOr<void> _onSwitchType(SwitchType event, Emitter<HomeState> emit) {
    emit(HomeInitial(isActive: event.isActive));
  }
}
