import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/models/models.dart';
import 'package:movie_app/ui/pages/explore/index.dart';
import 'package:movie_app/ui/pages/home/index.dart';
import 'package:movie_app/utils/utils.dart';

part 'born_today_event.dart';
part 'born_today_state.dart';

class BornTodayBloc extends Bloc<BornTodayEvent, BornTodayState> {
  final ExploreRepository exploreRepository = ExploreRepository(restApiClient: RestApiClient());
  final HomeRepository homeRepository = HomeRepository(restApiClient: RestApiClient());
  final ScrollController scrollController = ScrollController();

  BornTodayBloc()
      : super(BornTodayInitial(
          listArtist: [],
        )) {
    on<FetchData>(_onFetchData);
  }

  FutureOr<void> _onFetchData(FetchData event, Emitter<BornTodayState> emit) async {
    try {
      List<ArtistDetails> listArtist = [...state.listArtist];
      do {
        final result = await homeRepository.getPopularArtist(
          page: event.page++,
          language: event.language,
        );
        final listArtistDetails = await Future.wait(result.list.map<Future<ArtistDetails>>(
          (e) async {
            final listArtistResult = await exploreRepository.getDetailsArtist(
              personId: e.id ?? 0,
              language: event.language,
              appendToResponse: event.appendToResponse,
            );
            return listArtistResult.object;
          },
        ).toList())
          ..removeWhere((e) => e.birthday == null)
          ..removeWhere((e) => DateTime.parse(e.birthday ?? '').month != DateTime.now().month);
        listArtist.addAll(listArtistDetails);
      } while (listArtist.length <= 2);
      emit(BornTodaySuccess(
        listArtist: listArtist,
      ));
    } catch (e) {
      emit(BornTodayError(
        errorMessage: e.toString(),
        listArtist: state.listArtist,
      ));
    }
  }
}
