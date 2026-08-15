import 'package:mips/domain/entities/more_info.dart';
import 'package:mips/domain/usecases/more_info/get_all_more_info_usecase.dart';
import 'package:mips/domain/usecases/support/get_all_mips_info_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:mips/domain/entities/avis.dart';
import 'package:equatable/equatable.dart';

part 'mips_info_event.dart';
part 'mips_info_state.dart';

class MipsInfoBloc extends Bloc<MipsInfoEvent, MipsInfoState> {
  GetAllMipsInfoUsecase getAllMipsInfoUsecase;
  GetAllMoreInfoUsecase getAllMoreInfoUsecase;

  MipsInfoBloc({
    required this.getAllMipsInfoUsecase,
    required this.getAllMoreInfoUsecase,
  }) : super(
         MipsInfoState(
           avisList: [],
           moreInfoList: [],
           mipsInfoStatus: MipsInfoStatus.loading,
           moreInfoStatus: MoreInfoStatus.loading,
           error: "",
         ),
       ) {
    on<LoadMipsInfoListEvent>(_onLoadMipsInfoListEvent);
    on<LoadMoreInfoListEvent>(_onLoadMoreInfoListEvent);
  }

  _onLoadMipsInfoListEvent(LoadMipsInfoListEvent event, Emitter emit) async {
    emit(state.copyWith(mipsInfoStatus: MipsInfoStatus.loading));
    var result = await getAllMipsInfoUsecase();
    if (result.isSuccess()) {
      emit(
        state.copyWith(
          mipsInfoStatus: MipsInfoStatus.loaded,
          avisList: result.getSuccess(),
        ),
      );
    } else {
      emit(
        state.copyWith(
          mipsInfoStatus: MipsInfoStatus.error,
          error: result.getError()?.message,
        ),
      );
    }
  }

  _onLoadMoreInfoListEvent(LoadMoreInfoListEvent event, Emitter emit) async {
    emit(state.copyWith(moreInfoStatus: MoreInfoStatus.loading));
    var result = await getAllMoreInfoUsecase();
    if (result.isSuccess()) {
      emit(
        state.copyWith(
          moreInfoStatus: MoreInfoStatus.loaded,
          moreInfoList: result.getSuccess(),
        ),
      );
    } else {
      emit(
        state.copyWith(
          moreInfoStatus: MoreInfoStatus.error,
          error: result.getError()?.message,
        ),
      );
    }
  }
}
