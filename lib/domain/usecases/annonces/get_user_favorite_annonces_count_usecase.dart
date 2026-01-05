import 'package:MIPS/domain/domain.dart';

import '../../../common/common.dart';

class GetUserFavoriteAnnoncesCountUsecase {
  final AnnonceRepository annonceRepository;

  const GetUserFavoriteAnnoncesCountUsecase({
    required this.annonceRepository,
  });

  Future<Result<Failure, int>> call() async {
    // Preprocessing task: Try to compress file before upload
    return annonceRepository.getUserFavoriteAnnoncesCount();
  }
}
