import 'package:bloc/bloc.dart';

part 'genre_event.dart';
part 'genre_state.dart';

class GenreBloc extends Bloc<GenreEvent, GenreState> {
  GenreBloc() : super(GenreInitial()) {
    on<GenreEvent>((event, emit) {
    });
  }
}
