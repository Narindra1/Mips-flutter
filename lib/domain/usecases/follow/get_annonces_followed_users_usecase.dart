import 'package:MIPS/domain/contracts/follow_repository.dart';
import 'package:MIPS/domain/entities/annonce.dart';

import '../../../common/common.dart';

class GetAnnoncesFollowedUsersUsecase {
  final FollowRepository followRepository;
  const GetAnnoncesFollowedUsersUsecase({required this.followRepository});

  Future<Result<Failure, List<Annonce>>> call(int page, String query) async {
    return followRepository.getFetchAnnoncesOfFollowedUsers(page, query);
  }
}
