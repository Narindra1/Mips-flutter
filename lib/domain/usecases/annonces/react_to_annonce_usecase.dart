import 'package:MIPS/domain/domain.dart';

import '../../../common/common.dart';

class ReactToAnnonceUseCase {
  final AnnonceRepository annonceRepository;

  const ReactToAnnonceUseCase({
    required this.annonceRepository,
  });

  Future<Result<Failure, Annonce>> call(int id, bool isLike) async {
    return annonceRepository.reactAnnonce(id, isLike);
  }
}
