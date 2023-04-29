import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:movie_app/model/model.dart';
import 'package:movie_app/ui/home/index.dart';
import 'package:movie_app/utils/index.dart';

part 'now_playing_event.dart';
part 'now_playing_state.dart';

class NowPlayingBloc extends Bloc<NowPlayingEvent, NowPlayingState> {
  final HomeRepository homeRepository = HomeRepository(restApiClient: RestApiClient());
  NowPlayingBloc() : super(NowPlayingInitial(nowPlayingTv: MediaSynthesisDetails())) {
    on<FetchData>(_onFetchData);
  }

  FutureOr<void> _onFetchData(FetchData event, Emitter<NowPlayingState> emit) async {
    try {
      var result = await homeRepository.getNowPlayingTv(
        language: event.language,
        page: event.page,
      );
      var randomNowPlaying = (result.list..shuffle()).first;
      var resultDetails = await homeRepository.getDetailsTv(
        language: event.language,
        tvId: randomNowPlaying.id ?? 0,
        appendToResponse: null,
      );
      emit(NowPlayingSuccess(nowPlayingTv: resultDetails.object));
    } catch (e) {
      emit(NowPlayingError(
        errorMessage: e.toString(),
        nowPlayingTv: state.nowPlayingTv,
      ));
    }
  }
}
