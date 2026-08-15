import 'package:mips/domain/domain.dart';

import '../../../common/common.dart';

class GetUserAnnoncesCountUsecase {
  final AnnonceRepository annonceRepository;

  const GetUserAnnoncesCountUsecase({required this.annonceRepository});

  Future<Result<Failure, int>> call() async {
    // Preprocessing task: Try to compress file before upload
    return annonceRepository.getUserAnnoncesCount();
  }
}
