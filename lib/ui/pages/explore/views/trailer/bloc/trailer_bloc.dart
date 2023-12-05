import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:movie_app/models/models.dart';
import 'package:movie_app/ui/pages/explore/explore_repository.dart';
import 'package:movie_app/ui/pages/home/index.dart';
import 'package:movie_app/utils/utils.dart';

part 'trailer_event.dart';
part 'trailer_state.dart';

class TrailerBloc extends Bloc<TrailerEvent, TrailerState> {
  final HomeRepository homeRepository = HomeRepository(restApiClient: RestApiClient());
  final ExploreRepository exploreRepository = ExploreRepository(restApiClient: RestApiClient());
  final ScrollController theaterController = ScrollController();
  final ScrollController tvController = ScrollController();
  TrailerBloc()
      : super(TrailerInitial(
          listMovie: [],
          listTv: [],
          isActive: false,
          listTrailerMovie: [],
          listTrailerTv: [],
          visibleVideoMovie: List.filled(20, false),
          visibleVideoTv: List.filled(20, false),
        )) {
    on<FetchData>(_onFetchData);
    on<SwitchType>(_onSwitchType);
    on<PlayTrailer>(_onPlayTrailer);
    on<StopTrailer>(_onStopTrailer);
  }

  FutureOr<void> _onFetchData(FetchData event, Emitter<TrailerState> emit) async {
    try {
      final resultMovie = await exploreRepository.getNowPlayingMovie(
        language: event.language,
        page: event.page,
        region: event.region,
      );
      final resultTv = await homeRepository.getNowPlayingTv(
        language: event.language,
        page: event.page,
      );
      // call API trailer movie
      final listOfListTrailerMovie =
          await Future.wait(resultMovie.list.map<Future<List<MediaTrailer>>>(
        (e) async {
          final resultsTrailerMovie = await exploreRepository.getTrailerMovie(
            movieId: e.id ?? 0,
            language: event.language,
          );
          return resultsTrailerMovie.list.isEmpty ? [] : resultsTrailerMovie.list;
        },
      ).toList());
      final listTrailerMovie = listOfListTrailerMovie
          .map<MediaTrailer>((e) => e.isNotEmpty ? e.first : MediaTrailer(key: ''))
          .toList();
      // call API trailer tv
      final listOfListTrailerTv = await Future.wait(resultTv.list.map<Future<List<MediaTrailer>>>(
        (e) async {
          final resultsTrailerTv = await exploreRepository.getTrailerTv(
            seriesId: e.id ?? 0,
            language: event.language,
          );
          return resultsTrailerTv.list.isEmpty ? [] : resultsTrailerTv.list;
        },
      ).toList());
      final listTrailerTv = listOfListTrailerTv
          .map<MediaTrailer>((e) => e.isNotEmpty ? e.first : MediaTrailer(key: ''))
          .toList();
      emit(TrailerSuccess(
        listMovie: resultMovie.list,
        listTv: resultTv.list,
        listTrailerMovie: listTrailerMovie,
        listTrailerTv: listTrailerTv,
        isActive: state.isActive,
        visibleVideoMovie: state.visibleVideoMovie,
        visibleVideoTv: state.visibleVideoTv,
      ));
    } catch (e) {
      emit(TrailerError(
        errorMessage: e.toString(),
        listMovie: state.listMovie,
        listTv: state.listTv,
        listTrailerMovie: state.listTrailerMovie,
        listTrailerTv: state.listTrailerTv,
        isActive: state.isActive,
        visibleVideoMovie: state.visibleVideoMovie,
        visibleVideoTv: state.visibleVideoTv,
      ));
    }
  }

  FutureOr<void> _onSwitchType(SwitchType event, Emitter<TrailerState> emit) {
    try {
      emit(TrailerSuccess(
        listMovie: state.listMovie,
        listTv: state.listTv,
        listTrailerMovie: state.listTrailerMovie,
        listTrailerTv: state.listTrailerTv,
        isActive: event.isActive,
        visibleVideoMovie: List.filled(20, false),
        visibleVideoTv: List.filled(20, false),
      ));
    } catch (e) {
      emit(TrailerError(
        errorMessage: e.toString(),
        listMovie: state.listMovie,
        listTv: state.listTv,
        listTrailerMovie: state.listTrailerMovie,
        listTrailerTv: state.listTrailerTv,
        isActive: state.isActive,
        visibleVideoMovie: state.visibleVideoMovie,
        visibleVideoTv: state.visibleVideoTv,
      ));
    }
  }

  FutureOr<void> _onPlayTrailer(PlayTrailer event, Emitter<TrailerState> emit) {
    try {
      if (event.isActive) {
        event.visibleVideoTv[event.indexTv ?? 0] = !event.visibleVideoTv[event.indexTv ?? 0];
        for (int i = 0; i < event.visibleVideoTv.length; i++) {
          if (i != event.indexTv) {
            event.visibleVideoTv[i] = false;
          }
        }
      } else {
        event.visibleVideoMovie[event.indexMovie ?? 0] =
            !event.visibleVideoMovie[event.indexMovie ?? 0];
        for (int i = 0; i < event.visibleVideoMovie.length; i++) {
          if (i != event.indexMovie) {
            event.visibleVideoMovie[i] = false;
          }
        }
      }
      emit(TrailerSuccess(
        listMovie: state.listMovie,
        listTv: state.listTv,
        listTrailerMovie: state.listTrailerMovie,
        listTrailerTv: state.listTrailerTv,
        isActive: state.isActive,
        visibleVideoMovie: event.visibleVideoMovie,
        visibleVideoTv: event.visibleVideoTv,
      ));
    } catch (e) {
      emit(TrailerError(
        errorMessage: e.toString(),
        listMovie: state.listMovie,
        listTv: state.listTv,
        listTrailerMovie: state.listTrailerMovie,
        listTrailerTv: state.listTrailerTv,
        isActive: state.isActive,
        visibleVideoMovie: state.visibleVideoMovie,
        visibleVideoTv: state.visibleVideoTv,
      ));
    }
  }

  FutureOr<void> _onStopTrailer(StopTrailer event, Emitter<TrailerState> emit) {
    state is TrailerError
        ? emit(TrailerError(
            errorMessage: (state as TrailerError).errorMessage,
            listMovie: state.listMovie,
            listTv: state.listTv,
            listTrailerMovie: state.listTrailerMovie,
            listTrailerTv: state.listTrailerTv,
            isActive: state.isActive,
            visibleVideoMovie: state.visibleVideoMovie,
            visibleVideoTv: state.visibleVideoTv,
          ))
        : emit(TrailerSuccess(
            listMovie: state.listMovie,
            listTv: state.listTv,
            listTrailerMovie: state.listTrailerMovie,
            listTrailerTv: state.listTrailerTv,
            isActive: state.isActive,
            visibleVideoMovie: List.filled(20, false),
            visibleVideoTv: List.filled(20, false),
          ));
  }
}
