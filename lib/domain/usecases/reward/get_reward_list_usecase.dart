import 'package:mips/common/error/failures.dart';
import 'package:mips/common/result/results.dart';
import 'package:mips/domain/contracts/reward_repository.dart';
import 'package:mips/domain/entities/reward.dart';

class GetRewardListUsecase {
  final RewardRepository rewardRepository;

  const GetRewardListUsecase({required this.rewardRepository});

  Future<Result<Failure, List<Reward>>> call() async {
    return rewardRepository.getRewardList();
  }
}
