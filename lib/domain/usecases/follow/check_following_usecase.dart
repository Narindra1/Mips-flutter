import 'package:MIPS/domain/contracts/follow_repository.dart';

import '../../../common/common.dart';

class CheckFollowingUsecase {
  final FollowRepository followRepository;
  const CheckFollowingUsecase({required this.followRepository});

  Future<Result<Failure, bool>> call(int id) async {
    return followRepository.getCheckIsFollowingUser(id);
  }
}
