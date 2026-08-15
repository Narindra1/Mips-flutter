import 'package:mips/domain/domain.dart';

import '../../../common/common.dart';

class DeleteAnnonceUseCase {
  final AnnonceRepository annonceRepository;

  const DeleteAnnonceUseCase({required this.annonceRepository});

  Future<Result<Failure, SuccessResult>> call(String id) async {
    return annonceRepository.deleteAnnonce(id);
  }
}
