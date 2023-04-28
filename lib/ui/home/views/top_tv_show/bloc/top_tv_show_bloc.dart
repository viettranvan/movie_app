import 'package:bloc/bloc.dart';


part 'top_tv_show_event.dart';
part 'top_tv_show_state.dart';

class TopTvShowBloc extends Bloc<TopTvShowEvent, TopTvShowState> {
  TopTvShowBloc() : super(TopTvShowInitial()) {
    on<TopTvShowEvent>((event, emit) {
  
    });
  }
}
