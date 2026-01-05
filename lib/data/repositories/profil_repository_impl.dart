import 'package:MIPS/common/error/exceptions.dart';
import 'package:MIPS/common/error/failures.dart';
import 'package:MIPS/common/result/results.dart';
import 'package:MIPS/common/utils/app_utils.dart';
import 'package:MIPS/data/datasources/remote_datasource.dart';
import 'package:MIPS/domain/contracts/profil_repository.dart';
import 'package:MIPS/domain/domain.dart';

class ProfilRepositoryImpl implements ProfilRepository {
  const ProfilRepositoryImpl({required this.remoteDataSource});
  final RemoteDataSource remoteDataSource;

  @override
  Future<Result<Failure, User>> getUserInfoProfilById(int id) async {
    try {
      User user =
          (await remoteDataSource.fetchUserInfoProfilById(id)).toEntity();
      return Success(user);
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
  Future<Result<Failure, List<Annonce>>> getAnnoncesUserProfilById(
      int id, int page, String query) async {
    try {
      List<Annonce> annonces =
          (await remoteDataSource.fetchAnnoncesUserProfilById(id, page, query))
              .map((e) => e.toEntity())
              .toList();
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
  Future<Result<Failure, int>> getUserProfilAnnoncesCount(int id) async {
    try {
      int count = (await remoteDataSource.fetchUserProfilAnnoncesCount(id));
      return Success(count);
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
