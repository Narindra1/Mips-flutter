import 'package:mips/common/common.dart';
import 'package:mips/data/data.dart';
import 'package:mips/domain/domain.dart';

/// Implémentation du dépôt pour la gestion des sondages.
///
/// Utilise une source de données distante ([RemoteDataSource]) pour :
/// - récupérer la liste complète des sondages.
/// - soumettre la réponse d’un utilisateur à un sondage .

class SondageRepositoryImpl implements SondageRepository {
  final RemoteDataSource remoteDataSource;

  const SondageRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Result<Failure, List<Sondage>>> getAllSondage() async {
    try {
      var result = (await remoteDataSource.getAllSondage())
          .map((e) => e.toEntity())
          .toList();
      return Success(result);
    } on AppException catch (e) {
      AppUtils.showDebugLog(runtimeType, e.toString());
      if (e is NoConnectionException) {
        return Error(NoConnectionFailure());
      } else if (e is UserRegisterException) {
        return Error(UserRegisterFailure(message: (e.message.toString())));
      }
      return Error(ServerFailure(message: e.message));
    } on Exception catch (e) {
      return Error(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Result<Failure, Sondage>> submitSondage(
    int idSondage,
    int idResponseOption,
  ) async {
    try {
      var result = (await remoteDataSource.submitASondage(
        idSondage,
        idResponseOption,
      )).toEntity();
      return Success(result);
    } on AppException catch (e) {
      AppUtils.showDebugLog(runtimeType, e.toString());
      if (e is NoConnectionException) {
        return Error(NoConnectionFailure());
      } else if (e is UserRegisterException) {
        return Error(UserRegisterFailure(message: (e.message.toString())));
      }
      return Error(ServerFailure(message: e.message));
    } on Exception catch (e) {
      return Error(ServerFailure(message: e.toString()));
    }
  }
}
