part of 'rewards_bloc.dart';

sealed class RewardsEvent extends Equatable {
  const RewardsEvent();

  @override
  List<Object> get props => [];
}

class LoadRewardListEvent extends RewardsEvent {}
