import 'package:MIPS/common/error/exceptions.dart';
import 'package:MIPS/common/error/failures.dart';
import 'package:MIPS/common/result/results.dart';
import 'package:MIPS/common/utils/app_utils.dart';
import 'package:MIPS/data/datasources/remote_datasource.dart';
import 'package:MIPS/domain/contracts/kara_partner_repository.dart';
import 'package:MIPS/domain/entities/province.dart';

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
  Future<Result<Failure, SuccessResult>> karaSubscription() async {
    try {
      await remoteDataSource.karaSubscription();
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
