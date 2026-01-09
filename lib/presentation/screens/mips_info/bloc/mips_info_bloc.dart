import 'package:MIPS/domain/usecases/support/get_all_mips_info_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:MIPS/domain/entities/avis.dart';
import 'package:equatable/equatable.dart';

part 'mips_info_event.dart';
part 'mips_info_state.dart';

class MipsInfoBloc extends Bloc<MipsInfoEvent, MipsInfoState> {
  GetAllMipsInfoUsecase getAllMipsInfoUsecase;

  MipsInfoBloc({
    required this.getAllMipsInfoUsecase,
  }) : super(MipsInfoState(avisList: [], status: Status.loading, error: "")) {
    on<LoadMipsInfoListEvent>(_onLoadMipsInfoListEvent);
  }

  _onLoadMipsInfoListEvent(LoadMipsInfoListEvent event, Emitter emit) async {
    emit(state.copyWith(status: Status.loading));
    var result = await getAllMipsInfoUsecase();
    if (result.isSuccess()) {
      emit(
          state.copyWith(status: Status.loaded, avisList: result.getSuccess()));
    } else {
      emit(state.copyWith(
          status: Status.error, error: result.getError()?.message));
    }
  }
}
