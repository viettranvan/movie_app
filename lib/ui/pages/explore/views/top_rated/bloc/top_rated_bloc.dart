import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:movie_app/models/models.dart';
import 'package:movie_app/ui/pages/explore/index.dart';
import 'package:movie_app/utils/utils.dart';

part 'top_rated_event.dart';
part 'top_rated_state.dart';

class TopRatedBloc extends Bloc<TopRatedEvent, TopRatedState> {
  final ExploreRepository exploreRepository = ExploreRepository(restApiClient: RestApiClient());
  TopRatedBloc()
      : super(TopRatedInitial(
          listTopRated: [],
          listMovieState: [],
          statusMessage: '',
          index: 0,
        )) {
    on<FetcData>(_onFetcData);
    on<AddWatchList>(_onAddWatchList);
  }

  FutureOr<void> _onFetcData(FetcData event, Emitter<TopRatedState> emit) async {
    try {
      final result = await exploreRepository.getTopRatedMovie(
        language: event.language,
        page: event.page,
        region: event.region,
      );
      final movieStateList = await Future.wait(result.list.map<Future<MediaState>>(
        (e) async {
          final movieStateResult = await exploreRepository.getMovieState(
            movieId: e.id ?? 0,
            sessionId: event.sessionId,
          );
          return movieStateResult.object;
        },
      ).toList());
      emit(TopRatedSuccess(
        listTopRated: result.list,
        listMovieState: movieStateList,
        statusMessage: state.statusMessage,
        index: state.index,
      ));
    } catch (e) {
      emit(TopRatedError(
        errorMessage: e.toString(),
        listTopRated: state.listTopRated,
        listMovieState: state.listMovieState,
        statusMessage: state.statusMessage,
        index: state.index,
      ));
    }
  }

  FutureOr<void> _onAddWatchList(AddWatchList event, Emitter<TopRatedState> emit) async {
    try {
      final result = await exploreRepository.addWatchList(
        accountId: event.accountId,
        sessionId: event.sessionId,
        mediaType: event.mediaType,
        mediaId: event.mediaId,
        watchlist: event.watchlist,
      );
      emit(TopRatedAddWatchListSuccess(
        listTopRated: state.listTopRated,
        listMovieState: state.listMovieState,
        statusMessage: result.object.statusMessage ?? '',
        index: event.index,
      ));
    } catch (e) {
      emit(TopRatedAddWatchListError(
        errorMessage: e.toString(),
        listTopRated: state.listTopRated,
        listMovieState: state.listMovieState,
        statusMessage: state.statusMessage,
        index: state.index,
      ));
    }
  }
}
