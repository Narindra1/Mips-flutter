import 'package:MIPS/domain/contracts/follow_repository.dart';

import '../../../common/common.dart';

class FollowUserUsecase {
  final FollowRepository followRepository;
  const FollowUserUsecase({required this.followRepository});

  Future<Result<Failure, void>> call(int id) async {
    return followRepository.getFollowAnUser(id);
  }
}
