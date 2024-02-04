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
      List<int> pages = List.generate(5, (index) => index + 1);
      final results = await Future.wait(pages.map<Future<List<MediaArtist>>>(
        (e) async {
          final result = await homeRepository.getPopularArtist(
            page: e,
            language: event.language,
          );
          return result.list;
        },
      ).toList());
      final artistResult = results.expand((e) => e).toList();
      final artistList = await Future.wait(artistResult.map<Future<ArtistDetails>>(
        (e) async {
          final artistDetailsResult = await exploreRepository.getDetailsArtist(
            personId: e.id ?? 0,
            language: event.language,
            appendToResponse: event.appendToResponse,
          );
          return artistDetailsResult.object;
        },
      ).toList())
        ..removeWhere((e) => e.birthday == null)
        ..removeWhere(
            (e) => DateTime.parse(e.birthday ?? '').month != DateTime.parse('2024-01-03').month)
        ..removeWhere(
            (e) => DateTime.parse(e.birthday ?? '').day != DateTime.parse('2024-01-03').day);
      // final artistHaveBirthdayList = artistDetailsList;
      // final artistBirthdayList = artistHaveBirthdayList;
      emit(BornTodaySuccess(
        listArtist: artistList,
      ));
    } catch (e) {
      emit(BornTodayError(
        errorMessage: e.toString(),
        listArtist: state.listArtist,
      ));
    }
  }
}
