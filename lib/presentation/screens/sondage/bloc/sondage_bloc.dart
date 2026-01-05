import 'package:MIPS/domain/domain.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../domain/usecases/support/submit_a_sondage_usecase.dart';

part 'sondage_event.dart';

part 'sondage_state.dart';

class SondageBloc extends Bloc<SondageEvent, SondageState> {
  final GetAllSondageUseCase getAllSondageUseCase;
  final SubmitASondageUsecase submitASondageUsecase;

  SondageBloc(
      {required this.getAllSondageUseCase, required this.submitASondageUsecase})
      : super(const SondageState(
            status: Status.loaded,
            statusSubmitting: StatusSubmitting.submitSent,
            sondagesList: [],
            error: "")) {
    on<LoadSondagelistEvent>((event, emit) async {
      emit(state.copyWith(status: Status.loading));
      var result = await getAllSondageUseCase();
      if (result.isSuccess()) {
        emit(state.copyWith(
            status: Status.loaded, sondagesList: result.getSuccess()));
      } else {
        emit(state.copyWith(
            status: Status.error, error: result.getError()?.message));
      }
    });
    on<SubmitSondageEvent>((event, emit) async {
      emit(state.copyWith(statusSubmitting: StatusSubmitting.submitInProgress));
      var result =
          await submitASondageUsecase(event.sondageId, event.optionSelected);

      if (result.isSuccess()) {
        List<Sondage> sondages = state.sondagesList;
        int index =
            sondages.indexWhere((element) => element.id == event.sondageId);
        sondages[index] = result.getSuccess()!;
        emit(state.copyWith(
            statusSubmitting: StatusSubmitting.submitSent,
            sondagesList: sondages));
      } else {
        emit(state.copyWith(
            statusSubmitting: StatusSubmitting.submitError,
            error: result.getError()?.message));
      }
    });
  }
}
