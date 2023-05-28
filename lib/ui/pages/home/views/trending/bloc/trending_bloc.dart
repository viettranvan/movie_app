import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:movie_app/models/models.dart';
import 'package:movie_app/ui/pages/home/index.dart';
import 'package:movie_app/utils/utils.dart';

part 'trending_event.dart';
part 'trending_state.dart';

class TrendingBloc extends Bloc<TrendingEvent, TrendingState> {
  final HomeRepository homeRepository = HomeRepository(restApiClient: RestApiClient());
  TrendingBloc() : super(TrendingInitial(listTrending: [])) {
    on<FetchData>(_onFetchData);
  }

  FutureOr<void> _onFetchData(FetchData event, Emitter<TrendingState> emit) async {
    try {
      var result = await homeRepository.getTrendingMovie(
        mediaType: event.mediaType,
        timeWindow: event.timeWindow,
        page: event.page,
        language: event.language,
        includeAdult: event.includeAdult,
      );
      emit(TrendingSuccess(listTrending: result.list));
    } catch (e) {
      emit(TrendingError(
        errorMessage: e.toString(),
        listTrending: state.listTrending,
      ));
    }
  }
}
