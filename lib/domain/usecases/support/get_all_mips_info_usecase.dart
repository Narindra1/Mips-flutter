import 'package:mips/common/error/failures.dart';
import 'package:mips/common/result/results.dart';
import 'package:mips/domain/contracts/avis_repository.dart';
import 'package:mips/domain/entities/avis.dart';

class GetAllMipsInfoUsecase {
  final AvisRepository avisRepository;

  const GetAllMipsInfoUsecase({required this.avisRepository});

  Future<Result<Failure, List<Avis>>> call() {
    return avisRepository.getMipsInfoList();
  }
}
