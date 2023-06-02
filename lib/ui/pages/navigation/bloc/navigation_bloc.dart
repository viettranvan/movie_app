import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/ui/pages/explore/index.dart';
import 'package:movie_app/ui/pages/home/index.dart';
import 'package:movie_app/ui/pages/profile/index.dart';
import 'package:movie_app/ui/pages/search/index.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc()
      : super(
          NavigationInitial(
            indexPage: 0,
            pages: [
              const HomePage(),
              const ExplorePage(),
              const SearchPage(),
              const ProfilePage(),
            ],
          ),
        ) {
    on<NavigatePage>(_onNavigateScreen);
  }

  FutureOr<void> _onNavigateScreen(NavigatePage event, Emitter<NavigationState> emit) {
    emit(NavigationInitial(
      pages: state.pages,
      indexPage: event.indexPage,
    ));
  }
}
