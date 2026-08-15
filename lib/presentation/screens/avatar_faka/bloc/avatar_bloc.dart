import 'package:mips/domain/domain.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'avatar_event.dart';

part 'avatar_state.dart';

class AvatarBloc extends Bloc<AvatarEvent, AvatarState> {
  final BuyAvatarUseCase buyAvatarUseCase;
  final GetAvatarListUseCase getAvatarListUseCase;

  AvatarBloc({
    required this.getAvatarListUseCase,
    required this.buyAvatarUseCase,
  }) : super(
         const AvatarState(
           status: Status.loaded,
           statusBuy: StatusBuy.success,
           avatarList: [],
         ),
       ) {
    on<LoadAvatarListEvent>(_onLoadAvatarListEvent);
    on<BuyAvatarEvent>(_onBuyAvatarEvent);
    on<SelectedAvatarEvent>(_onSelectedAvatarEvent);
  }

  _onLoadAvatarListEvent(LoadAvatarListEvent event, Emitter emit) async {
    emit(state.copyWith(status: Status.loading));
    var result = await getAvatarListUseCase();
    if (result.isSuccess()) {
      emit(
        state.copyWith(status: Status.loaded, avatarList: result.getSuccess()),
      );
    } else {
      emit(state.copyWith(status: Status.error));
    }
  }

  _onSelectedAvatarEvent(SelectedAvatarEvent event, Emitter emit) async {
    emit(
      state.copyWith(
        selectedAvatar: state.avatarList.firstWhere(
          (element) => element.id == event.id,
        ),
      ),
    );
  }

  _onBuyAvatarEvent(BuyAvatarEvent event, Emitter emit) async {
    emit(state.copyWith(statusBuy: StatusBuy.loading));
    var result = await buyAvatarUseCase(
      event.id,
      event.number,
      event.moyenDePaiement,
    );
    if (result.isSuccess()) {
      emit(state.copyWith(statusBuy: StatusBuy.success));
    } else {
      emit(state.copyWith(statusBuy: StatusBuy.error));
    }
  }
}
