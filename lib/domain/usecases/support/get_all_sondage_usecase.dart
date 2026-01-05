import 'package:MIPS/common/common.dart';
import 'package:MIPS/domain/contracts/sondage_repository.dart';
import 'package:MIPS/domain/entities/sondage.dart';

class GetAllSondageUseCase {
  final SondageRepository sondageRepository;

  const GetAllSondageUseCase({
    required this.sondageRepository,
  });

  Future<Result<Failure, List<Sondage>>> call() async {
    return sondageRepository.getAllSondage();
  }
}
