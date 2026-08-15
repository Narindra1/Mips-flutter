import 'package:mips/domain/domain.dart';

import '../../../common/common.dart';

class UpdateAnnonceUseCase {
  final AnnonceRepository annonceRepository;

  const UpdateAnnonceUseCase({required this.annonceRepository});

  Future<Result<Failure, Annonce>> call(Annonce annonce) async {
    return annonceRepository.updateAnnonce(annonce);
  }
}
