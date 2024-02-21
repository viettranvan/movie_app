import 'dart:async';

import 'package:bloc/bloc.dart';

part 'watchlist_event.dart';
part 'watchlist_state.dart';

class WatchlistBloc extends Bloc<WatchlistEvent, WatchlistState> {
  WatchlistBloc()
      : super(WatchlistInitial(
          index: 0,
        )) {
    on<ChangeTab>(_onChangeTab);
  }

  FutureOr<void> _onChangeTab(ChangeTab event, Emitter<WatchlistState> emit) {
    emit(WatchlistInitial(
      index: event.index,
    ));
  }
}
