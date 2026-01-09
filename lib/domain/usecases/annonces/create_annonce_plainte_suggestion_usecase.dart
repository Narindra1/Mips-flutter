import 'package:MIPS/domain/domain.dart';

import '../../../common/common.dart';

class CreateAnnoncePlainteSuggestionUsecase {
  final AnnonceRepository annonceRepository;

  const CreateAnnoncePlainteSuggestionUsecase({
    required this.annonceRepository,
  });

  Future<Result<Failure, Annonce>> call(
      Annonce annonce, int idTarifOptions) async {
    return annonceRepository.createAnnoncePlainteSuggestion(
        annonce, idTarifOptions);
  }
}
