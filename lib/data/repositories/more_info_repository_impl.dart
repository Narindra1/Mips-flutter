import 'package:MIPS/common/error/failures.dart';
import 'package:MIPS/common/result/results.dart';
import 'package:MIPS/data/data.dart';
import 'package:MIPS/domain/contracts/more_info_repository.dart';
import 'package:MIPS/domain/entities/more_info.dart';

import '../../common/error/exceptions.dart';
import '../../common/utils/app_utils.dart';

class MoreInfoRepositoryImpl implements MoreInfoRepository {
  final RemoteDataSource remoteDataSource;

  const MoreInfoRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Result<Failure, List<MoreInfo>>> getMoreInfoList() async {
    try {
      List<MoreInfo> result = (await remoteDataSource.getAllMoreInfo())
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
