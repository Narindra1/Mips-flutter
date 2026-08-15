import 'package:mips/common/common.dart';
import 'package:mips/domain/domain.dart';

class ExtendValidityAnnonceUsecase {
  final AnnonceRepository annonceRepository;

  const ExtendValidityAnnonceUsecase({required this.annonceRepository});

  Future<Result<Failure, Annonce>> call(
    int idAnnonce,
    int idTarifOption,
  ) async {
    return annonceRepository.extendDateAnnonce(idAnnonce, idTarifOption);
  }
}
