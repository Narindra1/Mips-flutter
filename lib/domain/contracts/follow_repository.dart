import 'package:MIPS/common/common.dart';
import 'package:MIPS/domain/domain.dart';

abstract class FollowRepository {
  Future<Result<Failure, int>> getAnnoncesFollowedUsersCount();
  Future<Result<Failure, bool>> getCheckIsFollowingUser(int id);
  Future<Result<Failure, void>> getFollowAnUser(int id);
  Future<Result<Failure, void>> getUnfollowAnUser(int id);
  Future<Result<Failure, List<User>>> getFetchMyFollowersUsers();
  Future<Result<Failure, List<User>>> getFetchMyFollowingUsers();
  Future<Result<Failure, List<Annonce>>> getFetchAnnoncesOfFollowedUsers(
      int page, String query);
}
