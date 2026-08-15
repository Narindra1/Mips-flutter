import 'package:mips/common/common.dart';
import 'package:mips/domain/entities/more_info.dart';

abstract class MoreInfoRepository {
  Future<Result<Failure, List<MoreInfo>>> getMoreInfoList();
}
