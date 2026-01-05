import 'package:MIPS/domain/domain.dart';

import '../../../common/common.dart';

class GetRecentsAnnoncesUsecase {
  final AnnonceRepository annonceRepository;

  const GetRecentsAnnoncesUsecase({
    required this.annonceRepository,
  });

  Future<Result<Failure, List<Annonce>>> call(
      int idScreen, int page, String query) async {
    return annonceRepository.getRecentsAnnonces(idScreen, page, query);
  }
}
