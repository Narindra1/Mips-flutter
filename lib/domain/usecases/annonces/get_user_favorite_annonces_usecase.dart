import 'package:MIPS/domain/domain.dart';

import '../../../common/common.dart';

class GetUserFavoriteAnnoncesUsecase {
  final AnnonceRepository annonceRepository;

  const GetUserFavoriteAnnoncesUsecase({
    required this.annonceRepository,
  });

  Future<Result<Failure, List<Annonce>>> call(int page, String query) async {
    // Preprocessing task: Try to compress file before upload
    return annonceRepository.getUserFavoriteAnnonces(page, query);
  }
}
