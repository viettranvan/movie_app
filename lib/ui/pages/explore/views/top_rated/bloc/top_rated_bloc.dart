import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:movie_app/models/media/media.dart';
import 'package:movie_app/ui/pages/explore/index.dart';
import 'package:movie_app/utils/utils.dart';

part 'top_rated_event.dart';
part 'top_rated_state.dart';

class TopRatedBloc extends Bloc<TopRatedEvent, TopRatedState> {
  final ExploreRepository exploreRepository = ExploreRepository(restApiClient: RestApiClient());
  TopRatedBloc()
      : super(TopRatedInitial(
          listTopRated: [],
        )) {
    on<FetcData>(_onFetcData);
  }

  FutureOr<void> _onFetcData(FetcData event, Emitter<TopRatedState> emit) async {
    try {
      final result = await exploreRepository.getTopRatedMovie(
        language: event.language,
        page: event.page,
        region: event.region,
      );
      emit(TopRatedSuccess(listTopRated: result.list));
    } catch (e) {
      emit(TopRatedError(
        errorMessage: e.toString(),
        listTopRated: state.listTopRated,
      ));
    }
  }
}
