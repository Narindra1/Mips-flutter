import 'package:mips/domain/domain.dart';

import '../../../common/common.dart';

class CreateAnnonceUseCase {
  final AnnonceRepository annonceRepository;

  const CreateAnnonceUseCase({required this.annonceRepository});

  Future<Result<Failure, Annonce>> call(
    Annonce annonce,
    int idTarifOptions,
  ) async {
    return annonceRepository.createAnnonce(annonce, idTarifOptions);
  }
}
