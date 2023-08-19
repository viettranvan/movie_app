import 'dart:async';

import 'package:bloc/bloc.dart';

part 'watch_list_event.dart';
part 'watch_list_state.dart';

class WatchListBloc extends Bloc<WatchListEvent, WatchListState> {
  WatchListBloc()
      : super(WatchListInitial(
          index: 0,
        )) {
    on<ChangeTab>(_onChangeTab);
  }

  FutureOr<void> _onChangeTab(ChangeTab event, Emitter<WatchListState> emit) {
    emit(WatchListInitial(
      index: event.index,
    ));
  }
}
