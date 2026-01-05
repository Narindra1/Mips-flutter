import 'package:MIPS/common/error/failures.dart';
import 'package:MIPS/common/result/results.dart';
import 'package:MIPS/domain/contracts/avis_repository.dart';
import 'package:MIPS/domain/entities/avis.dart';

class GetAllAvisUseCase {
  final AvisRepository avisRepository;

  const GetAllAvisUseCase({
    required this.avisRepository,
  });

  Future<Result<Failure, List<Avis>>> call() {
    return avisRepository.getAvisList();
  }
}
