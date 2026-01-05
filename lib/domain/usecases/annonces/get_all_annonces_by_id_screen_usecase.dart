import 'package:MIPS/domain/domain.dart';

import '../../../common/common.dart';

class GetAllAnnoncesByIdScreenUseCase {
  final AnnonceRepository annonceRepository;

  const GetAllAnnoncesByIdScreenUseCase({
    required this.annonceRepository,
  });

  Future<Result<Failure, List<Annonce>>> call(
      int idScreen, int page, String query) async {
    return annonceRepository.getAllAnnoncesByScreenID(idScreen, page, query);
  }
}
