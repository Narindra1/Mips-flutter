import 'package:MIPS/domain/domain.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'maha_partenaire_event.dart';

part 'maha_partenaire_state.dart';

class MahaPartenaireBloc
    extends Bloc<MahaPartenaireEvent, MahaPartenaireState> {
  final GetAllMahaPartenaireUseCase getAllMahaPartenaireUseCase;

  MahaPartenaireBloc({required this.getAllMahaPartenaireUseCase})
      : super(const MahaPartenaireState(
            mahaPartenaireElts: [], error: "", status: Status.loaded)) {
    on<LoadMahaPartenaireListEvent>((event, emit) async {
      emit(state.copyWith(status: Status.loading));
      var result = await getAllMahaPartenaireUseCase();
      if (result.isSuccess()) {
        emit(state.copyWith(
            mahaPartenaireElts: result.getSuccess(), status: Status.loaded));
      } else {
        emit(state.copyWith(
            error: result.getError()?.message, status: Status.error));
      }
    });
  }
}
