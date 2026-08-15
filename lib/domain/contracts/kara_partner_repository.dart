import 'package:mips/common/common.dart';
import 'package:mips/domain/entities/annonce.dart';
import 'package:mips/domain/entities/province.dart';

abstract class KaraPartnerRepository {
  Future<Result<Failure, List<Province>>> getKaraProvinceList();
  Future<Result<Failure, SuccessResult>> karaSubscription(
    List<String> provinces,
    String slug,
  );
  Future<Result<Failure, List<Annonce>>> fetchKaraAnnoncesByProvince(
    String province,
    int page,
    String query,
  );
}
