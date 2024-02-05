import 'package:bloc/bloc.dart';

part 'movie_provider_event.dart';
part 'movie_provider_state.dart';

class MovieProviderBloc extends Bloc<MovieProviderEvent, MovieProviderState> {
  MovieProviderBloc() : super(MovieProviderInitial()) {
    on<MovieProviderEvent>((event, emit) {
    });
  }
}
