import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:movie_app/models/models.dart';
import 'package:movie_app/ui/pages/explore/index.dart';
import 'package:movie_app/utils/utils.dart';

part 'media_provider_event.dart';
part 'media_provider_state.dart';

class MediaProviderBloc extends Bloc<MediaProviderEvent, MediaProviderState> {
  final ExploreRepository exploreRepository = ExploreRepository(restApiClient: RestApiClient());
  final ScrollController movieController = ScrollController();
  final ScrollController tvController = ScrollController();
  MediaProviderBloc()
      : super(MediaProviderInitial(
          status: false,
          listMovieProviders: [],
          listTvProviders: [],
        )) {
    on<FetchData>(_onFetchData);
    on<ChangeList>(_onChangeList);
  }
  FutureOr<void> _onFetchData(FetchData event, Emitter<MediaProviderState> emit) async {
    try {
      final movieResult = await exploreRepository.getMovieProvider(
        language: event.language,
        watchRegion: event.watchRegion ?? '',
      );
      final tvResult = await exploreRepository.getTvProvider(
        language: event.language,
        watchRegion: event.watchRegion ?? '',
      );
      emit(MediaProviderSuccess(
        status: state.status,
        listMovieProviders: movieResult.list,
        listTvProviders: tvResult.list,
      ));
    } catch (e) {
      emit(MediaProviderError(
        errorMessage: e.toString(),
        status: state.status,
        listMovieProviders: state.listMovieProviders,
        listTvProviders: state.listTvProviders,
      ));
    }
  }

  FutureOr<void> _onChangeList(ChangeList event, Emitter<MediaProviderState> emit) {
    try {
      emit(MediaProviderSuccess(
        listMovieProviders: state.listMovieProviders,
        listTvProviders: state.listTvProviders,
        status: event.status,
      ));
    } catch (e) {
      emit(MediaProviderError(
        errorMessage: e.toString(),
        status: state.status,
        listMovieProviders: state.listMovieProviders,
        listTvProviders: state.listTvProviders,
      ));
    }
  }
}
