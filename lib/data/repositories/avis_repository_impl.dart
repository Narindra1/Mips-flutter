import 'package:MIPS/common/error/failures.dart';
import 'package:MIPS/common/result/results.dart';
import 'package:MIPS/data/data.dart';
import 'package:MIPS/domain/contracts/avis_repository.dart';
import 'package:MIPS/domain/entities/avis.dart';

import '../../common/error/exceptions.dart';
import '../../common/utils/app_utils.dart';

/// Implémentation du dépôt pour la gestion des elements dans menu avis.
///
/// Utilise une source de données distante ([RemoteDataSource]) pour
/// récupérer la liste ou un avis.
class AvisRepositoryImpl implements AvisRepository {
  final RemoteDataSource remoteDataSource;

  const AvisRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Result<Failure, Avis>> getAvis(int id) async {
    try {
      Avis result = (await remoteDataSource.getAAvis(id)).toEntity();

      return Success(result);
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
  Future<Result<Failure, List<Avis>>> getAvisList() async {
    try {
      List<Avis> result = (await remoteDataSource.getAllAvis())
          .map((e) => e.toEntity())
          .toList();

      return Success(result);
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
