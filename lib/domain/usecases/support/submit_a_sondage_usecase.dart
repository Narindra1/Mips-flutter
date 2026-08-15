import 'package:mips/common/common.dart';
import 'package:mips/domain/contracts/sondage_repository.dart';
import 'package:mips/domain/entities/sondage.dart';

class SubmitASondageUsecase {
  final SondageRepository sondageRepository;

  const SubmitASondageUsecase({required this.sondageRepository});

  Future<Result<Failure, Sondage>> call(
    int idSondage,
    int idResponseOption,
  ) async {
    return sondageRepository.submitSondage(idSondage, idResponseOption);
  }
}
