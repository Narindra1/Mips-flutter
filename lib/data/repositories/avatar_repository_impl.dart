import 'package:MIPS/common/error/failures.dart';
import 'package:MIPS/common/result/results.dart';
import 'package:MIPS/data/data.dart';
import 'package:MIPS/domain/contracts/avatar_repository.dart';
import 'package:MIPS/domain/entities/avatar.dart';

import '../../common/error/exceptions.dart';
import '../../common/utils/app_utils.dart';

/// Implémentation du dépôt pour la gestion des avatars.
///
/// Utilise une source de données distante ([RemoteDataSource]) pour
/// récupérer, acheter les avatars des utilisateurs.
class AvatarRepositoryImpl implements AvatarRepository {
  final RemoteDataSource remoteDataSource;

  const AvatarRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Result<Failure, SuccessResult>> buyAvatar(
      int id, int nombre, String moyenDePaiement) async {
    try {
      (await remoteDataSource.getAllAvis());
      return const Success(SuccessResult());
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
  Future<Result<Failure, List<Avatar>>> getAvatarList() async {
    try {
      List<Avatar> result = (await remoteDataSource.fetchAvatarList())
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
