import 'package:mips/common/common.dart';
import 'package:mips/domain/entities/reward.dart';

abstract class RewardRepository {
  Future<Result<Failure, List<Reward>>> getRewardList();
}
