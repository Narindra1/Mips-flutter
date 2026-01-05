import 'package:MIPS/common/common.dart';
import 'package:MIPS/domain/contracts/sondage_repository.dart';
import 'package:MIPS/domain/entities/sondage.dart';

class SubmitASondageUsecase {
  final SondageRepository sondageRepository;

  const SubmitASondageUsecase({
    required this.sondageRepository,
  });

  Future<Result<Failure, Sondage>> call(
      int idSondage, int idResponseOption) async {
    return sondageRepository.submitSondage(idSondage, idResponseOption);
  }
}
