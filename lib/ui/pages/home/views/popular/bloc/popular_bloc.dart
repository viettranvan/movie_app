import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:movie_app/model/model.dart';
import 'package:movie_app/ui/pages/home/index.dart';
import 'package:movie_app/utils/rest_api_client/index.dart';
import 'package:movie_app/utils/utils.dart';

part 'popular_event.dart';
part 'popular_state.dart';

class PopularBloc extends Bloc<PopularEvent, PopularState> {
  final HomeRepository homeRepository = HomeRepository(restApiClient: RestApiClient());
  CarouselController controller = CarouselController();
  PopularBloc()
      : super(PopularInitial(
          listPopular: [],
          selectedIndex: 0,
        )) {
    on<SlidePageView>(_onSlidePageView);
    on<FetchData>(_onFetchData);
  }

  FutureOr<void> _onFetchData(FetchData event, Emitter<PopularState> emit) async {
    try {
      var result = await homeRepository.getPopularMovie(
        language: event.language,
        page: 1,
        region: event.region,
      );
      emit(PopularSuccess(
        listPopular: result.list,
        selectedIndex: state.selectedIndex,
      ));
    } catch (e) {
      emit(PopularError(
        errorMessage: e.toString(),
        listPopular: state.listPopular,
        selectedIndex: state.selectedIndex,
      ));
    }
  }

  FutureOr<void> _onSlidePageView(SlidePageView event, Emitter<PopularState> emit) {
    emit(PopularSuccess(
      listPopular: state.listPopular,
      selectedIndex: event.selectedIndex,
    ));
  }
}
