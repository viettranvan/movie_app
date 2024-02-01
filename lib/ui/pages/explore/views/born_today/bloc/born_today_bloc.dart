import 'package:bloc/bloc.dart';

part 'born_today_event.dart';
part 'born_today_state.dart';

class BornTodayBloc extends Bloc<BornTodayEvent, BornTodayState> {
  BornTodayBloc() : super(BornTodayInitial()) {
    on<BornTodayEvent>((event, emit) {
    });
  }
}
