import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/models/genre/media_genre.dart';
import 'package:movie_app/ui/pages/home/index.dart';
import 'package:movie_app/utils/utils.dart';

part 'genre_event.dart';
part 'genre_state.dart';

class GenreBloc extends Bloc<GenreEvent, GenreState> {
  final HomeRepository homeRepository = HomeRepository(restApiClient: RestApiClient());
  ScrollController movieController = ScrollController();
  ScrollController tvController = ScrollController();
  bool visibleMovie = true;
  bool visibleTv = false;
  GenreBloc()
      : super(GenreInitial(
          listGenreMovie: [],
          listGenreTv: [],
          status: false,
        )) {
    on<FetchData>(_onFetchData);
    on<ChangeList>(_onChangeList);
  }

  FutureOr<void> _onFetchData(FetchData event, Emitter<GenreState> emit) async {
    try {
      var movieResult = await homeRepository.getGenreMovie(language: event.language);
      var tvResult = await homeRepository.getGenreTv(language: event.language);
      emit(GenreSuccess(
        listGenreMovie: movieResult.object.genres,
        listGenreTv: tvResult.object.genres,
        status: state.status,
      ));
    } catch (e) {
      emit(GenreError(
        errorMessage: e.toString(),
        listGenreMovie: state.listGenreMovie,
        listGenreTv: state.listGenreTv,
        status: state.status,
      ));
    }
  }

  FutureOr<void> _onChangeList(ChangeList event, Emitter<GenreState> emit) {
    try {
      emit(GenreSuccess(
        status: event.status,
        listGenreMovie: state.listGenreMovie,
        listGenreTv: state.listGenreTv,
      ));
    } catch (e) {
      emit(GenreError(
        errorMessage: e.toString(),
        listGenreMovie: state.listGenreMovie,
        listGenreTv: state.listGenreTv,
        status: state.status,
      ));
    }
  }
}
