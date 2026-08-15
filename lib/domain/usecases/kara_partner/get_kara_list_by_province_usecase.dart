import 'package:mips/domain/contracts/kara_partner_repository.dart';
import 'package:mips/domain/entities/annonce.dart';

import '../../../common/common.dart';

class GetKaraListByProvinceUsecase {
  final KaraPartnerRepository karaPartnerRepository;

  const GetKaraListByProvinceUsecase({required this.karaPartnerRepository});

  Future<Result<Failure, List<Annonce>>> call(
    String province,
    int page,
    String query,
  ) async {
    return karaPartnerRepository.fetchKaraAnnoncesByProvince(
      province,
      page,
      query,
    );
  }
}
