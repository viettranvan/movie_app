import 'package:bloc/bloc.dart';

part 'watch_list_event.dart';
part 'watch_list_state.dart';

class WatchListBloc extends Bloc<WatchListEvent, WatchListState> {
  WatchListBloc() : super(WatchListInitial()) {
    on<WatchListEvent>((event, emit) {
    });
  }
}
