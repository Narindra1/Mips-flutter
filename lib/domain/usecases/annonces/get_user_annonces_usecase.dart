import 'package:MIPS/domain/domain.dart';

import '../../../common/common.dart';

class GetUserAnnoncesUseCase {
  final AnnonceRepository annonceRepository;

  const GetUserAnnoncesUseCase({
    required this.annonceRepository,
  });

  Future<Result<Failure, List<Annonce>>> call(int page, String query) async {
    // Preprocessing task: Try to compress file before upload
    return annonceRepository.getUserAnnonces(page, query);
  }
}
