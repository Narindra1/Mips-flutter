import 'package:MIPS/common/common.dart';
import 'package:MIPS/domain/entities/reward.dart';

abstract class RewardRepository {
  Future<Result<Failure, List<Reward>>> getRewardList();
}
