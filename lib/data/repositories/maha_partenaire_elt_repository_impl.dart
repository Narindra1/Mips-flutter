import 'package:mips/data/data.dart';
import 'package:mips/domain/contracts/maha_partenaire_elt_repository.dart';
import 'package:mips/domain/entities/maha_partenaire_elt.dart';
import '../../common/common.dart';

/// Implémentation du dépôt pour la gestion des éléments du menu Maha Partenaire.
///
/// Utilise une source de données distante ([RemoteDataSource]) pour
/// recupérer les elements dans maha partenaires.

class MahaPartenaireEltRepositoryImpl implements MahaPartenaireEltRepository {
  final RemoteDataSource remoteDataSource;

  const MahaPartenaireEltRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Result<Failure, List<MahaPartenaireElt>>>
  getAllMahaPartenaireElt() async {
    try {
      var result = (await remoteDataSource.getAllMahaPartenaire())
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
}
