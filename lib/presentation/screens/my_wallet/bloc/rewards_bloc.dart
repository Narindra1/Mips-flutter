import 'package:MIPS/domain/entities/reward.dart';
import 'package:MIPS/domain/usecases/reward/get_reward_list_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'rewards_event.dart';
part 'rewards_state.dart';

class RewardsBloc extends Bloc<RewardsEvent, RewardsState> {
  RewardsBloc({required this.getRewardListUsecase})
      : super(RewardsState(rewards: [], status: Status.loaded, error: '')) {
    on<RewardsEvent>((event, emit) async {
      emit(state.copyWith(status: Status.loading));
      var result = await getRewardListUsecase();
      if (result.isSuccess()) {
        emit(state.copyWith(
            rewards: result.getSuccess(), status: Status.loaded));
      } else {
        emit(state.copyWith(
            error: result.getError()?.message, status: Status.error));
      }
    });
  }
  final GetRewardListUsecase getRewardListUsecase;
}
