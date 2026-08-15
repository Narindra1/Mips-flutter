import 'package:mips/common/error/failures.dart';
import 'package:mips/common/result/results.dart';
import 'package:mips/domain/contracts/avis_repository.dart';
import 'package:mips/domain/entities/avis.dart';

class GetAAvisUseCase {
  final AvisRepository avisRepository;

  const GetAAvisUseCase({required this.avisRepository});

  Future<Result<Failure, Avis>> call(int id) {
    return avisRepository.getAvis(id);
  }
}
