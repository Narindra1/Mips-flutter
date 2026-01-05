import 'package:MIPS/common/common.dart';
import 'package:MIPS/domain/domain.dart';

class ExtendValidityAnnonceUsecase {
  final AnnonceRepository annonceRepository;

  const ExtendValidityAnnonceUsecase({required this.annonceRepository});

  Future<Result<Failure, Annonce>> call(
      int idAnnonce, int idTarifOption) async {
    return annonceRepository.extendDateAnnonce(idAnnonce, idTarifOption);
  }
}
