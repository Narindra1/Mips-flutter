import 'package:mips/domain/domain.dart';

import '../../../common/common.dart';

class GetBonusFromAnnonceUsecase {
  final AnnonceRepository annonceRepository;

  const GetBonusFromAnnonceUsecase({required this.annonceRepository});

  Future<Result<Failure, SuccessResult>> call(int id) async {
    return annonceRepository.getBonusFromAnnonce(id);
  }
}
