import 'package:MIPS/common/common.dart';
import 'package:MIPS/domain/entities/more_info.dart';

abstract class MoreInfoRepository {
  Future<Result<Failure, List<MoreInfo>>> getMoreInfoList();
}
