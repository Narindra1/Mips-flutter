import 'package:MIPS/common/error/failures.dart';
import 'package:MIPS/common/result/results.dart';
import 'package:MIPS/data/data.dart';
import 'package:MIPS/domain/contracts/exchange_rate_repository.dart';
import 'package:MIPS/domain/entities/exchange_rate.dart';

import '../../common/error/exceptions.dart';
import '../../common/utils/app_utils.dart';

/// Implémentation du dépôt pour la gestion des avatars.
///
/// Utilise une source de données distante ([RemoteDataSource]) pour
/// récupérer, acheter les avatars des utilisateurs.
class ExchangeRateRepositoryImpl implements ExchangeRateRepository {
  final RemoteDataSource remoteDataSource;

  const ExchangeRateRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Result<Failure, ExchangeRate>> getExchangeRate() async {
    try {
      ExchangeRate result =
          (await remoteDataSource.fetchExchangeRate()).toEntity();
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
