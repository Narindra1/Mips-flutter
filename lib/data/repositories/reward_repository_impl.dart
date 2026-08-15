import 'package:mips/common/error/failures.dart';
import 'package:mips/common/result/results.dart';
import 'package:mips/data/data.dart';
import 'package:mips/domain/contracts/reward_repository.dart';
import 'package:mips/domain/entities/reward.dart';

import '../../common/error/exceptions.dart';
import '../../common/utils/app_utils.dart';

/// Implémentation du dépôt pour la gestion des avatars.
///
/// Utilise une source de données distante ([RemoteDataSource]) pour
/// récupérer, acheter les avatars des utilisateurs.
class RewardRepositoryImpl implements RewardRepository {
  final RemoteDataSource remoteDataSource;

  const RewardRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Result<Failure, List<Reward>>> getRewardList() async {
    try {
      List<Reward> result = (await remoteDataSource.fetchRewardList())
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
