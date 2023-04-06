import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/ui/discovery/discovery_page.dart';
import 'package:movie_app/ui/home/home_page.dart';
import 'package:movie_app/ui/profile/profile_page.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  int indexPage = 0;
  NavigationBloc()
      : super(
          NavigationInitial(
            pages: [
              const HomePage(),
              const DiscoveryPage(),
              const ProfilePage(),
            ],
          ),
        ) {
    on<NavigateScreen>(_onNavigateScreen);
  }

  FutureOr<void> _onNavigateScreen(NavigateScreen event, Emitter<NavigationState> emit) {
    indexPage = event.indexPage;
    emit(NavigationInitial(
      pages: state.pages,
    ));
  }
}
