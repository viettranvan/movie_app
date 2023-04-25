import 'package:bloc/bloc.dart';

part 'artist_event.dart';
part 'artist_state.dart';

class ArtistBloc extends Bloc<ArtistEvent, ArtistState> {
  ArtistBloc() : super(ArtistInitial()) {
    on<ArtistEvent>((event, emit) {
    });
  }
}
