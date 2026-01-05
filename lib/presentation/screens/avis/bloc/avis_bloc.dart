import 'package:MIPS/domain/domain.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'avis_event.dart';

part 'avis_state.dart';

class AvisBloc extends Bloc<AvisEvent, AvisState> {
  final GetAAvisUseCase getAAvisUseCase;
  final GetAllAvisUseCase getAllAvisUseCase;

  AvisBloc({required this.getAllAvisUseCase, required this.getAAvisUseCase})
      : super(const AvisState(avisList: [], status: Status.loaded, error: "")) {
    on<LoadAnAvisEvent>(_onLoadAnAvisEvent);
    on<LoadListEvent>(_onLoadListEvent);
  }

  _onLoadAnAvisEvent(LoadAnAvisEvent event, Emitter emit) async {
    emit(state.copyWith(status: Status.loading));
    var result = await getAAvisUseCase(event.id);
    if (result.isSuccess()) {
      emit(
          state.copyWith(status: Status.loaded, selected: result.getSuccess()));
    } else {
      emit(state.copyWith(
          status: Status.error, error: result.getError()?.message));
    }
  }

  _onLoadListEvent(LoadListEvent event, Emitter emit) async {
    emit(state.copyWith(status: Status.loading));
    var result = await getAllAvisUseCase();
    if (result.isSuccess()) {
      emit(
          state.copyWith(status: Status.loaded, avisList: result.getSuccess()));
    } else {
      emit(state.copyWith(
          status: Status.error, error: result.getError()?.message));
    }
  }
}
