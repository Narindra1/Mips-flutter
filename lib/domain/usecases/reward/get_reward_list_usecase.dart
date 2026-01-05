import 'package:MIPS/common/error/failures.dart';
import 'package:MIPS/common/result/results.dart';
import 'package:MIPS/domain/contracts/reward_repository.dart';
import 'package:MIPS/domain/entities/reward.dart';

class GetRewardListUsecase {
  final RewardRepository rewardRepository;

  const GetRewardListUsecase({
    required this.rewardRepository,
  });

  Future<Result<Failure, List<Reward>>> call() async {
    return rewardRepository.getRewardList();
  }
}
