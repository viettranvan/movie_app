import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:movie_app/model/genre/media_genre/media_genre.dart';
import 'package:movie_app/ui/pages/home/index.dart';
import 'package:movie_app/utils/utils.dart';

part 'genre_event.dart';
part 'genre_state.dart';

class GenreBloc extends Bloc<GenreEvent, GenreState> {
  bool visibleMovie = true;
  bool visibleTv = false;
  final HomeRepository homeRepository = HomeRepository(restApiClient: RestApiClient());
  GenreBloc()
      : super(GenreInitial(
          visibleMovie: true,
          visibleTv: false,
          listGenreMovie: [],
          listGenreTv: [],
        )) {
    on<FetchData>(_onFetchData);
    on<VisbleList>(_onVisbleList);
  }

  FutureOr<void> _onFetchData(FetchData event, Emitter<GenreState> emit) async {
    try {
      var movieResult = await homeRepository.getGenreMovie(language: event.language);
      var tvResult = await homeRepository.getGenreTv(language: event.language);
      emit(GenreSuccess(
        visibleMovie: state.visibleMovie,
        visibleTv: state.visibleTv,
        listGenreMovie: movieResult.object.genres,
        listGenreTv: tvResult.object.genres,
      ));
    } catch (e) {
      emit(GenreError(
        visibleMovie: state.visibleMovie,
        visibleTv: state.visibleTv,
        errorMessage: e.toString(),
        listGenreMovie: state.listGenreMovie,
        listGenreTv: state.listGenreTv,
      ));
    }
  }

  FutureOr<void> _onVisbleList(VisbleList event, Emitter<GenreState> emit) {
    emit(GenreSuccess(
      listGenreMovie: state.listGenreMovie,
      listGenreTv: state.listGenreTv,
      visibleMovie: event.visibleMovie,
      visibleTv: event.visibleTv,
    ));
  }
}
