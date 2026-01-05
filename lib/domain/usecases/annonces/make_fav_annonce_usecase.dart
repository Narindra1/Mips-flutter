import 'package:MIPS/domain/domain.dart';

import '../../../common/common.dart';

class MakeFavAnnonceUseCase {
  final AnnonceRepository annonceRepository;

  const MakeFavAnnonceUseCase({
    required this.annonceRepository,
  });

  Future<Result<Failure, Annonce>> call(int id, bool isLike) async {
    return annonceRepository.makeFavAnnonce(id, isLike);
  }
}
