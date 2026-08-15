import 'package:mips/common/common.dart';
import 'package:mips/domain/contracts/sondage_repository.dart';
import 'package:mips/domain/entities/sondage.dart';

class GetAllSondageUseCase {
  final SondageRepository sondageRepository;

  const GetAllSondageUseCase({required this.sondageRepository});

  Future<Result<Failure, List<Sondage>>> call() async {
    return sondageRepository.getAllSondage();
  }
}
