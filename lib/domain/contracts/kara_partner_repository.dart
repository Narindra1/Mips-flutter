import 'package:MIPS/common/common.dart';
import 'package:MIPS/domain/entities/province.dart';

abstract class KaraPartnerRepository {
  Future<Result<Failure, List<Province>>> getKaraProvinceList();
  Future<Result<Failure, SuccessResult>> karaSubscription();
}
