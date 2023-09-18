import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:movie_app/models/models.dart';
import 'package:movie_app/ui/pages/explore/explore_repository.dart';
import 'package:movie_app/utils/utils.dart';

part 'latest_trailer_event.dart';
part 'latest_trailer_state.dart';

class TrailerBloc extends Bloc<TrailerEvent, TrailerState> {
  final ExploreRepository exploreRepository = ExploreRepository(restApiClient: RestApiClient());
  TrailerBloc() : super(TrailerInitial(listTopRated: [])) {
    on<FetchData>(_onFetchData);
  }

  FutureOr<void> _onFetchData(FetchData event, Emitter<TrailerState> emit) async {
    try {
      final result = await exploreRepository.getTopRatedMovie(
        language: event.language,
        page: event.page,
        region: event.region,
      );
      emit(TrailerSuccess(listTopRated: result.list));
    } catch (e) {
      emit(TrailerError(
        errorMessage: e.toString(),
        listTopRated: state.listTopRated,
      ));
    }
  }
}
