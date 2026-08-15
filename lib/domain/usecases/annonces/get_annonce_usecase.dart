import 'package:mips/domain/domain.dart';

import '../../../common/common.dart';

class GetAnnonceUseCase {
  final AnnonceRepository annonceRepository;

  const GetAnnonceUseCase({required this.annonceRepository});
  Future<Result<Failure, Annonce>> call(String id) async {
    return annonceRepository.getAnnonceByID(id);
  }
}
