import 'package:mips/domain/contracts/kara_partner_repository.dart';
import 'package:mips/domain/entities/province.dart';

import '../../../common/common.dart';

class GetKaraProvinceListUsecase {
  final KaraPartnerRepository karaPartnerRepository;

  const GetKaraProvinceListUsecase({required this.karaPartnerRepository});

  Future<Result<Failure, List<Province>>> call() async {
    return karaPartnerRepository.getKaraProvinceList();
  }
}
