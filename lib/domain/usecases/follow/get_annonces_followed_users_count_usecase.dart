import 'package:MIPS/domain/contracts/follow_repository.dart';

import '../../../common/common.dart';

class GetAnnoncesFollowedUsersCountUsecase {
  final FollowRepository followRepository;
  const GetAnnoncesFollowedUsersCountUsecase({required this.followRepository});

  Future<Result<Failure, int>> call() async {
    return followRepository.getAnnoncesFollowedUsersCount();
  }
}
