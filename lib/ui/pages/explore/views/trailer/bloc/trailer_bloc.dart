import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:movie_app/models/models.dart';
import 'package:movie_app/ui/pages/explore/explore_repository.dart';
import 'package:movie_app/ui/pages/home/index.dart';
import 'package:movie_app/utils/app_utils/app_utils.dart';
import 'package:movie_app/utils/utils.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

part 'trailer_event.dart';
part 'trailer_state.dart';

class TrailerBloc extends Bloc<TrailerEvent, TrailerState> {
  final HomeRepository homeRepository = HomeRepository(restApiClient: RestApiClient());
  final ExploreRepository exploreRepository = ExploreRepository(restApiClient: RestApiClient());
  final ScrollController theaterController = ScrollController();

  final ScrollController tvController = ScrollController();
  TrailerBloc()
      : super(TrailerInitial(
          listMovie: [],
          listTv: [],
          isActive: false,
          listTrailerMovie: [],
          listTrailerTv: [],
          movieControllers: [],
          tvControllers: [],
          currentIndexMovie: -1,
          currentIndexTv: -1,
          visibleVideoMovie: List.generate(20, (index) => false),
          visibleVideoTv: List.generate(20, (index) => false),
        )) {
    on<FetchData>(_onFetchData);
    on<SwitchType>(_onSwitchType);
    on<ShowMovieVideo>(_onShowMovieVideo);
    on<PlayTrailer>(_onPlayTrailer);
  }

  FutureOr<void> _onFetchData(FetchData event, Emitter<TrailerState> emit) async {
    try {
      final resultMovie = await exploreRepository.getNowPlayingMovie(
        language: event.language,
        page: event.page,
        region: event.region,
      );
      final resultTv = await homeRepository.getNowPlayingTv(
        language: event.language,
        page: event.page,
      );
      // call API trailer movie
      final listTrailerMovie = await AppUtils().getTrailersMovie({
        'list_movie': resultMovie.list,
        'language': event.language,
      });
      // call API trailer tv
      final listTrailerTv = await AppUtils().getTrailersTv({
        'list_tv': resultTv.list,
        'language': event.language,
      });
      emit(TrailerSuccess(
        listMovie: resultMovie.list,
        listTv: resultTv.list,
        listTrailerMovie: listTrailerMovie,
        listTrailerTv: listTrailerTv,
        movieControllers: state.movieControllers,
        tvControllers: state.tvControllers,
        isActive: state.isActive,
        currentIndexMovie: state.currentIndexMovie,
        currentIndexTv: state.currentIndexTv,
        visibleVideoMovie: state.visibleVideoMovie,
        visibleVideoTv: state.visibleVideoTv,
      ));
    } catch (e) {
      emit(TrailerError(
        errorMessage: e.toString(),
        listMovie: state.listMovie,
        listTv: state.listTv,
        listTrailerMovie: state.listTrailerMovie,
        listTrailerTv: state.listTrailerTv,
        movieControllers: state.movieControllers,
        tvControllers: state.tvControllers,
        isActive: state.isActive,
        currentIndexMovie: state.currentIndexMovie,
        currentIndexTv: state.currentIndexTv,
        visibleVideoMovie: state.visibleVideoMovie,
        visibleVideoTv: state.visibleVideoTv,
      ));
    }
  }

  FutureOr<void> _onSwitchType(SwitchType event, Emitter<TrailerState> emit) {
    emit(TrailerSuccess(
      listMovie: state.listMovie,
      listTv: state.listTv,
      listTrailerMovie: state.listTrailerMovie,
      listTrailerTv: state.listTrailerTv,
      movieControllers: state.movieControllers,
      tvControllers: state.tvControllers,
      isActive: event.isActive,
      currentIndexMovie: state.currentIndexMovie,
      currentIndexTv: state.currentIndexTv,
      visibleVideoMovie: List.generate(20, (index) => false),
      visibleVideoTv: List.generate(20, (index) => false),
    ));
  }

  FutureOr<void> _onShowMovieVideo(ShowMovieVideo event, Emitter<TrailerState> emit) {
    try {
      if (!state.isActive) {
        if (state.currentIndexMovie != event.currentIndexMovie) {
          if (state.currentIndexMovie != -1) {
            event.visibleVideoMovie[state.currentIndexMovie] = false;
          }
          state.currentIndexMovie = event.currentIndexMovie ?? 0;
          event.visibleVideoMovie[event.currentIndexMovie ?? 0] = true;
        } else {
          event.visibleVideoMovie[event.currentIndexMovie ?? 0] =
              !event.visibleVideoMovie[event.currentIndexMovie ?? 0];
          emit(TrailerSuccess(
            listMovie: state.listMovie,
            listTv: state.listTv,
            listTrailerMovie: state.listTrailerMovie,
            listTrailerTv: state.listTrailerTv,
            movieControllers: state.movieControllers,
            tvControllers: state.tvControllers,
            isActive: state.isActive,
            currentIndexMovie: state.currentIndexMovie,
            currentIndexTv: state.currentIndexTv,
            visibleVideoMovie: event.visibleVideoMovie,
            visibleVideoTv: state.visibleVideoTv,
          ));
        }
      } else {
        if (state.currentIndexTv != event.currentIndexTv) {
          if (state.currentIndexTv != -1) {
            event.visibleVideoTv[state.currentIndexTv] = false;
          }
          state.currentIndexTv = event.currentIndexTv ?? 0;
          event.visibleVideoTv[event.currentIndexTv ?? 0] = true;
        } else {
          event.visibleVideoTv[event.currentIndexTv ?? 0] =
              !event.visibleVideoTv[event.currentIndexTv ?? 0];
          emit(TrailerSuccess(
            listMovie: state.listMovie,
            listTv: state.listTv,
            listTrailerMovie: state.listTrailerMovie,
            listTrailerTv: state.listTrailerTv,
            movieControllers: state.movieControllers,
            tvControllers: state.tvControllers,
            isActive: state.isActive,
            currentIndexMovie: state.currentIndexMovie,
            currentIndexTv: state.currentIndexTv,
            visibleVideoMovie: event.visibleVideoTv,
            visibleVideoTv: state.visibleVideoTv,
          ));
        }
      }
    } catch (e) {
      emit(TrailerError(
        errorMessage: e.toString(),
        listMovie: state.listMovie,
        listTv: state.listTv,
        listTrailerMovie: state.listTrailerMovie,
        listTrailerTv: state.listTrailerTv,
        movieControllers: state.movieControllers,
        tvControllers: state.tvControllers,
        isActive: state.isActive,
        currentIndexMovie: state.currentIndexMovie,
        currentIndexTv: state.currentIndexTv,
        visibleVideoMovie: state.visibleVideoMovie,
        visibleVideoTv: state.visibleVideoTv,
      ));
    }
  }

  FutureOr<void> _onPlayTrailer(PlayTrailer event, Emitter<TrailerState> emit) {
    List<YoutubePlayerController> movieControllers = [];
    List<YoutubePlayerController> tvControllers = [];
    if (!state.isActive) {
      if (state.currentIndexMovie != -1) {
        movieControllers.clear();
      }
      if (state.listTrailerMovie[event.currentIndexMovie ?? 0].key!.isNotEmpty) {
        final movieController = YoutubePlayerController(
            initialVideoId: state.listTrailerMovie[event.currentIndexMovie ?? 0].key ?? '',
            flags: const YoutubePlayerFlags(
              hideControls: true,
              autoPlay: true,
              mute: false,
              disableDragSeek: true,
              enableCaption: false,
              useHybridComposition: true,
              forceHD: false,
            ));
        movieControllers.add(movieController);
        tvControllers.clear();
      } else {
        movieControllers.clear();
        tvControllers.clear();
      }
    } else {
      if (state.currentIndexTv != -1) {
        tvControllers.clear();
      }
      if (state.listTrailerTv[event.currentIndexTv ?? 0].key!.isNotEmpty) {
        final tvController = YoutubePlayerController(
            initialVideoId: state.listTrailerTv[event.currentIndexTv ?? 0].key ?? '',
            flags: const YoutubePlayerFlags(
              hideControls: true,
              autoPlay: true,
              mute: false,
              disableDragSeek: true,
              enableCaption: false,
              useHybridComposition: true,
              forceHD: false,
            ));
        tvControllers.add(tvController);
        movieControllers.clear();
      } else {
        movieControllers.clear();
        tvControllers.clear();
      }
    }

    emit(TrailerSuccess(
      listMovie: state.listMovie,
      listTv: state.listTv,
      listTrailerMovie: state.listTrailerMovie,
      listTrailerTv: state.listTrailerTv,
      movieControllers: movieControllers,
      tvControllers: tvControllers,
      isActive: state.isActive,
      currentIndexMovie: state.currentIndexMovie,
      currentIndexTv: state.currentIndexTv,
      visibleVideoMovie: state.visibleVideoMovie,
      visibleVideoTv: state.visibleVideoTv,
    ));
  }
}
