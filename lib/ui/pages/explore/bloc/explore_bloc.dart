import 'package:bloc/bloc.dart';

part 'explore_event.dart';
part 'explore_state.dart';

class ExploreBloc extends Bloc<ExploreEvent, ExploreState> {
  ExploreBloc() : super(ExploreInitial()) {
    on<ExploreEvent>((event, emit) {});
  }
}
