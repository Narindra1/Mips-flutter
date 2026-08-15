import 'package:mips/domain/contracts/follow_repository.dart';

import '../../../common/common.dart';

class UnfollowUserUsecase {
  final FollowRepository followRepository;
  const UnfollowUserUsecase({required this.followRepository});

  Future<Result<Failure, void>> call(int id) async {
    return followRepository.getUnfollowAnUser(id);
  }
}
