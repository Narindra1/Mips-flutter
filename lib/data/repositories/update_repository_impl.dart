import 'package:MIPS/common/error/failures.dart';

import 'package:MIPS/common/result/results.dart';
import 'package:MIPS/data/data.dart';

import '../../common/error/exceptions.dart';
import '../../common/utils/app_utils.dart';
import '../../domain/contracts/update_repository.dart';

/// Implémentation du dépôt pour la gestion des mises à jour.
///
/// Utilise une source de données distante ([RemoteDataSource]) pour vérifier
/// la disponibilité d’une mise à jour de l'application.
///
class UpdateRepositoryImpl implements UpdateRepository {
  final RemoteDataSource remoteDataSource;

  @override
  Future<Result<Failure, String>> checkUpdate() async {
    try {
      String result = (await remoteDataSource.checkUpdate());
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

  const UpdateRepositoryImpl({
    required this.remoteDataSource,
  });
}
