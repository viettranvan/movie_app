import 'dart:async';

import 'package:bloc/bloc.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  FavoriteBloc()
      : super(FavoriteInitial(
          index: 0,
        )) {
    on<ChangeTab>(_onChangeTab);
  }

  FutureOr<void> _onChangeTab(ChangeTab event, Emitter<FavoriteState> emit) {
    emit(FavoriteInitial(
      index: event.index,
    ));
  }
}
