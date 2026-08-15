import 'package:mips/domain/contracts/profil_repository.dart';
import 'package:mips/domain/entities/annonce.dart';

import '../../../common/common.dart';

class GetAnnoncesUserProfilUsecase {
  final ProfilRepository profilRepository;

  const GetAnnoncesUserProfilUsecase({required this.profilRepository});

  Future<Result<Failure, List<Annonce>>> call(
    int id,
    int page,
    String query,
  ) async {
    return profilRepository.getAnnoncesUserProfilById(id, page, query);
  }
}
