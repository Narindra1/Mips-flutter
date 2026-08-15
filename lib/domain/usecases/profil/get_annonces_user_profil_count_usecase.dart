import 'package:mips/domain/contracts/profil_repository.dart';

import '../../../common/common.dart';

class GetAnnoncesUserProfilCountUsecase {
  final ProfilRepository profilRepository;

  const GetAnnoncesUserProfilCountUsecase({required this.profilRepository});

  Future<Result<Failure, int>> call(int id) async {
    return profilRepository.getUserProfilAnnoncesCount(id);
  }
}
