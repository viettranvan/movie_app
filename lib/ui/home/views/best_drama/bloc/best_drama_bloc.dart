import 'package:bloc/bloc.dart';

part 'best_drama_event.dart';
part 'best_drama_state.dart';

class BestDramaBloc extends Bloc<BestDramaEvent, BestDramaState> {
  BestDramaBloc() : super(BestDramaInitial()) {
    on<BestDramaEvent>((event, emit) {
    });
  }
}
