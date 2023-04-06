import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'discovery_event.dart';
part 'discovery_state.dart';

class DiscoveryBloc extends Bloc<DiscoveryEvent, DiscoveryState> {
  DiscoveryBloc() : super(DiscoveryInitial()) {
    on<DiscoveryEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
