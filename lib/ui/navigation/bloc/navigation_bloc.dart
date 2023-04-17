import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/ui/favorite/favorite_page.dart';
import 'package:movie_app/ui/home/home_page.dart';
import 'package:movie_app/ui/profile/profile_page.dart';
import 'package:movie_app/ui/search/search_page.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc()
      : super(
          NavigationInitial(
            indexPage: 0,
            pages: [
              const HomePage(),
              const FavoritePage(),
              const SearchPage(),
              const ProfilePage(),
            ],
          ),
        ) {
    on<NavigateScreen>(_onNavigateScreen);
  }

  FutureOr<void> _onNavigateScreen(NavigateScreen event, Emitter<NavigationState> emit) {
    emit(NavigationInitial(
      pages: state.pages,
      indexPage: event.indexPage,
    ));
  }
}
