import 'package:bloc/bloc.dart';

part 'tv_provider_event.dart';
part 'tv_provider_state.dart';

class TvProviderBloc extends Bloc<TvProviderEvent, TvProviderState> {
  TvProviderBloc() : super(TvProviderInitial()) {
    on<TvProviderEvent>((event, emit) {});
  }
}
