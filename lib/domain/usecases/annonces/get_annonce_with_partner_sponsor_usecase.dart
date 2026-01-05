import 'package:MIPS/domain/domain.dart';

import '../../../common/common.dart';

class GetAnnonceWithPartnerSponsorUsecase {
  final AnnonceRepository annonceRepository;

  const GetAnnonceWithPartnerSponsorUsecase({
    required this.annonceRepository,
  });

  Future<Result<Failure, List<Annonce>>> call(String id) async {
    return annonceRepository.getAnnonceByIDWithPartnerSponsor(id);
  }
}
