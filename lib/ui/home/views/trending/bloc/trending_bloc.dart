import 'package:bloc/bloc.dart';

part 'trending_event.dart';
part 'trending_state.dart';

class TrendingBloc extends Bloc<TrendingEvent, TrendingState> {
  TrendingBloc() : super(TrendingInitial()) {
    on<TrendingEvent>((event, emit) {
    });
  }
}
