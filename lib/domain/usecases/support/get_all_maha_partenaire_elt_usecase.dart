import 'package:MIPS/domain/contracts/maha_partenaire_elt_repository.dart';
import 'package:MIPS/domain/entities/maha_partenaire_elt.dart';

import '../../../common/common.dart';

class GetAllMahaPartenaireUseCase {
  final MahaPartenaireEltRepository mahaPartenaireEltRepository;

  const GetAllMahaPartenaireUseCase({
    required this.mahaPartenaireEltRepository,
  });

  Future<Result<Failure, List<MahaPartenaireElt>>> call() {
    return mahaPartenaireEltRepository.getAllMahaPartenaireElt();
  }
}
