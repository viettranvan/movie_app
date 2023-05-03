import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:movie_app/model/model.dart';
import 'package:movie_app/ui/home/index.dart';
import 'package:movie_app/utils/app_utils/app_utils.dart';
import 'package:movie_app/utils/utils.dart';

part 'now_playing_event.dart';
part 'now_playing_state.dart';

class NowPlayingBloc extends Bloc<NowPlayingEvent, NowPlayingState> {
  final HomeRepository homeRepository = HomeRepository(restApiClient: RestApiClient());
  NowPlayingBloc()
      : super(NowPlayingInitial(
          nowPlayingTv: MediaSynthesisDetails(),
          paletteColors: [],
        )) {
    on<FetchData>(_onFetchData);
    on<ChangeColor>(_onChangeColor);
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
      emit(NowPlayingSuccess(
        nowPlayingTv: resultDetails.object,
        paletteColors: [],
      ));
    } catch (e) {
      emit(NowPlayingError(
        errorMessage: e.toString(),
        nowPlayingTv: state.nowPlayingTv,
        paletteColors: state.paletteColors,
      ));
    }
  }

  FutureOr<void> _onChangeColor(ChangeColor event, Emitter<NowPlayingState> emit) async {
    try {
      if (event.imagePath.isNotEmpty) {
        final baseUrl = Uri.parse(event.imagePath);
        final loadImage = await NetworkAssetBundle(baseUrl).load(event.imagePath);
        final imageBytes = loadImage.buffer.asUint8List(); // load the image
        final colors = AppUtils().extractPixelsColors(imageBytes);
        final paletteColors = AppUtils().generatePalette({'palette': colors, 'numberOfItems': 16});
        emit(NowPlayingSuccess(
          paletteColors: paletteColors,
          nowPlayingTv: state.nowPlayingTv,
        ));
      }
    } catch (e) {
      emit(NowPlayingError(
        errorMessage: e.toString(),
        nowPlayingTv: state.nowPlayingTv,
        paletteColors: state.paletteColors,
      ));
    }
  }
}
