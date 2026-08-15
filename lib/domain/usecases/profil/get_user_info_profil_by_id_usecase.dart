import 'package:mips/domain/contracts/profil_repository.dart';
import 'package:mips/domain/domain.dart';

import '../../../common/common.dart';

class GetUserInfoProfilByIdUsecase {
  final ProfilRepository profilRepository;

  const GetUserInfoProfilByIdUsecase({required this.profilRepository});

  Future<Result<Failure, User>> call(int id) async {
    return profilRepository.getUserInfoProfilById(id);
  }
}
