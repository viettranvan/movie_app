import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:movie_app/models/models.dart';
import 'package:movie_app/ui/pages/home/index.dart';
import 'package:movie_app/utils/utils.dart';

part 'best_drama_event.dart';
part 'best_drama_state.dart';

class BestDramaBloc extends Bloc<BestDramaEvent, BestDramaState> {
  final HomeRepository homeRepository = HomeRepository(restApiClient: RestApiClient());
  ScrollController scrollController = ScrollController();
  BestDramaBloc() : super(BestDramaInitial(listBestDrama: [])) {
    on<FetchData>(_onFetchData);
  }

  FutureOr<void> _onFetchData(FetchData event, Emitter<BestDramaState> emit) async {
    try {
      var result = await homeRepository.getDiscoverTv(
        language: event.language,
        page: event.page,
        withGenres: event.withGenres,
      );
      emit(BestDramaSuccess(listBestDrama: result.list));
    } catch (e) {
      emit(BestDramaError(
        errorMessage: e.toString(),
        listBestDrama: state.listBestDrama,
      ));
    }
  }
}
