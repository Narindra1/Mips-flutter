import 'package:MIPS/common/error/failures.dart';
import 'package:MIPS/common/result/results.dart';
import 'package:MIPS/domain/contracts/devise_repository.dart';
import 'package:MIPS/domain/entities/devise.dart';

class GetDeviseListUsecase {
  final DeviseRepository deviseRepository;

  const GetDeviseListUsecase({
    required this.deviseRepository,
  });

  Future<Result<Failure, List<Devise>>> call() async {
    return deviseRepository.getDeviseList();
  }
}
