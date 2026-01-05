part of 'rewards_bloc.dart';

enum Status { loaded, loading, error }

class RewardsState extends Equatable {
  const RewardsState({
    required this.rewards,
    required this.status,
    required this.error,
  });
  final List<Reward> rewards;
  final Status status;
  final String error;

  RewardsState copyWith({
    List<Reward>? rewards,
    Status? status,
    String? error,
  }) {
    return RewardsState(
      rewards: rewards ?? this.rewards,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }

  @override
  List<Object> get props => [rewards, status, error];
}
