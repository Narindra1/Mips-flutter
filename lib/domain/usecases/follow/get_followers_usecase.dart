import 'package:MIPS/domain/contracts/follow_repository.dart';
import 'package:MIPS/domain/domain.dart';

import '../../../common/common.dart';

class GetFollowersUsecase {
  final FollowRepository followRepository;
  const GetFollowersUsecase({required this.followRepository});

  Future<Result<Failure, List<User>>> call() async {
    return followRepository.getFetchMyFollowersUsers();
  }
}
