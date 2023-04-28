import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:movie_app/model/model.dart';
import 'package:movie_app/ui/home/index.dart';
import 'package:movie_app/utils/index.dart';

part 'now_playing_event.dart';
part 'now_playing_state.dart';

class NowPlayingBloc extends Bloc<NowPlayingEvent, NowPlayingState> {
  final HomeRepository homeRepository = HomeRepository(restApiClient: RestApiClient());
  NowPlayingBloc() : super(NowPlayingInitial(nowPlayingTv: MediaSynthesis())) {
    on<FetchData>(_onFetchData);
  }

  FutureOr<void> _onFetchData(FetchData event, Emitter<NowPlayingState> emit) async {
    try {
      var result = await homeRepository.getNowPlayingTv(
        language: event.language,
        page: event.page,
      );
      // var random = Random();
      // var nowPlayingTv = result.list[random.nextInt(result.list.length)];
      var nowPlayingTv = (result.list..shuffle()).first;
      emit(NowPlayingSuccess(nowPlayingTv: nowPlayingTv));
    } catch (e) {
      emit(NowPlayingError(
        errorMessage: e.toString(),
        nowPlayingTv: state.nowPlayingTv,
      ));
    }
  }
}
