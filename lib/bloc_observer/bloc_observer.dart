import 'dart:developer';

import 'package:bloc/bloc.dart';

class SimpleBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    // log('Bloc');
    log('Bloc: ${bloc.runtimeType} \nEvent: ${event.runtimeType} \nState: ${bloc.state.runtimeType} ');
  }
}
