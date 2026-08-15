import 'package:mips/common/error/exceptions.dart';
import 'package:mips/common/error/failures.dart';
import 'package:mips/common/result/results.dart';
import 'package:mips/common/utils/app_utils.dart';
import 'package:mips/data/datasources/remote_datasource.dart';
import 'package:mips/domain/contracts/follow_repository.dart';
import 'package:mips/domain/entities/annonce.dart';
import 'package:mips/domain/entities/user.dart';

class FollowRepositoryImpl implements FollowRepository {
  const FollowRepositoryImpl({required this.remoteDataSource});
  final RemoteDataSource remoteDataSource;

  @override
  Future<Result<Failure, int>> getAnnoncesFollowedUsersCount() async {
    try {
      int annoncesCount = (await remoteDataSource
          .fetchAnnoncesFollowedUsersCount());
      return Success(annoncesCount);
    } on AppException catch (e) {
      AppUtils.showDebugLog(runtimeType, e.toString());
      if (e is NoConnectionException) {
        return Error(NoConnectionFailure());
      }
      return Error(ServerFailure(message: e.message));
    } on Exception catch (e) {
      return Error(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Result<Failure, bool>> getCheckIsFollowingUser(int id) async {
    try {
      bool isFollowing = (await remoteDataSource.checkIsFollowingUser(id));
      return Success(isFollowing);
    } on AppException catch (e) {
      AppUtils.showDebugLog(runtimeType, e.toString());
      if (e is NoConnectionException) {
        return Error(NoConnectionFailure());
      }
      return Error(ServerFailure(message: e.message));
    } on Exception catch (e) {
      return Error(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Result<Failure, List<Annonce>>> getFetchAnnoncesOfFollowedUsers(
    int page,
    String query,
  ) async {
    try {
      List<Annonce> annonces =
          (await remoteDataSource.fetchAnnoncesOfFollowedUsers(
            page,
            query,
          )).map((e) => e.toEntity()).toList();
      return Success(annonces);
    } on AppException catch (e) {
      AppUtils.showDebugLog(runtimeType, e.toString());
      if (e is NoConnectionException) {
        return Error(NoConnectionFailure());
      }
      return Error(ServerFailure(message: e.message));
    } on Exception catch (e) {
      return Error(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Result<Failure, List<User>>> getFetchMyFollowersUsers() async {
    try {
      List<User> followers = (await remoteDataSource.fetchMyFollowersUsers())
          .map((e) => e.toEntity())
          .toList();
      return Success(followers);
    } on AppException catch (e) {
      AppUtils.showDebugLog(runtimeType, e.toString());
      if (e is NoConnectionException) {
        return Error(NoConnectionFailure());
      }
      return Error(ServerFailure(message: e.message));
    } on Exception catch (e) {
      return Error(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Result<Failure, List<User>>> getFetchMyFollowingUsers() async {
    try {
      List<User> following = (await remoteDataSource.fetchMyFollowingUsers())
          .map((e) => e.toEntity())
          .toList();
      return Success(following);
    } on AppException catch (e) {
      AppUtils.showDebugLog(runtimeType, e.toString());
      if (e is NoConnectionException) {
        return Error(NoConnectionFailure());
      }
      return Error(ServerFailure(message: e.message));
    } on Exception catch (e) {
      return Error(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Result<Failure, SuccessResult>> getFollowAnUser(int id) async {
    try {
      await remoteDataSource.followAnUser(id);
      return Success(SuccessResult());
    } on AppException catch (e) {
      AppUtils.showDebugLog(runtimeType, e.toString());
      if (e is NoConnectionException) {
        return Error(NoConnectionFailure());
      }
      return Error(ServerFailure(message: e.message));
    } on Exception catch (e) {
      return Error(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Result<Failure, SuccessResult>> getUnfollowAnUser(int id) async {
    try {
      await remoteDataSource.unfollowAnUser(id);
      return Success(SuccessResult());
    } on AppException catch (e) {
      AppUtils.showDebugLog(runtimeType, e.toString());
      if (e is NoConnectionException) {
        return Error(NoConnectionFailure());
      }
      return Error(ServerFailure(message: e.message));
    } on Exception catch (e) {
      return Error(ServerFailure(message: e.toString()));
    }
  }
}
