import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:movie_app/model/model.dart';
import 'package:movie_app/ui/pages/index.dart';
import 'package:movie_app/utils/utils.dart';

part 'upcoming_event.dart';
part 'upcoming_state.dart';

class UpcomingBloc extends Bloc<UpcomingEvent, UpcomingState> {
  final HomeRepository homeRepository = HomeRepository(restApiClient: RestApiClient());
  UpcomingBloc() : super(UpcomingInitial(listUpcoming: [])) {
    on<FetchData>(_onFetchData);
  }

  FutureOr<void> _onFetchData(FetchData event, Emitter<UpcomingState> emit) async {
    
    try {
      var result = await homeRepository.getUpcomingMovie(
        language: event.language,
        page: event.page,
        region: event.region,
      );
      emit(UpcomingSuccess(listUpcoming: result.list));
    } catch (e) {
      emit(UpcomingError(
        errorMessage: e.toString(),
        listUpcoming: state.listUpcoming,
      ));
    }
  }
}
