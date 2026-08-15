import 'package:mips/common/error/exceptions.dart';
import 'package:mips/common/error/failures.dart';
import 'package:mips/common/result/results.dart';
import 'package:mips/common/utils/app_utils.dart';
import 'package:mips/data/datasources/remote_datasource.dart';
import 'package:mips/domain/contracts/kara_partner_repository.dart';
import 'package:mips/domain/entities/annonce.dart';
import 'package:mips/domain/entities/province.dart';

class KaraPartnerRepositoryImpl implements KaraPartnerRepository {
  const KaraPartnerRepositoryImpl({required this.remoteDataSource});
  final RemoteDataSource remoteDataSource;

  @override
  Future<Result<Failure, List<Province>>> getKaraProvinceList() async {
    try {
      List<Province> annonces = (await remoteDataSource.fetchKaraProvinceList())
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
  Future<Result<Failure, List<Annonce>>> fetchKaraAnnoncesByProvince(
    String province,
    int page,
    String query,
  ) async {
    try {
      List<Annonce> annonces =
          (await remoteDataSource.fetchKaraAnnoncesByProvince(
            province,
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
  Future<Result<Failure, SuccessResult>> karaSubscription(
    List<String> provinces,
    String slug,
  ) async {
    try {
      await remoteDataSource.karaSubscription(provinces, slug);
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
}
