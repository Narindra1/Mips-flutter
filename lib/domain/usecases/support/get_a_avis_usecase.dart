import 'package:MIPS/common/error/failures.dart';
import 'package:MIPS/common/result/results.dart';
import 'package:MIPS/domain/contracts/avis_repository.dart';
import 'package:MIPS/domain/entities/avis.dart';

class GetAAvisUseCase {
  final AvisRepository avisRepository;

  const GetAAvisUseCase({
    required this.avisRepository,
  });

  Future<Result<Failure, Avis>> call(int id) {
    return avisRepository.getAvis(id);
  }
}
