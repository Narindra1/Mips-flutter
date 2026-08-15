import 'package:mips/common/error/failures.dart';
import 'package:mips/common/result/results.dart';
import 'package:mips/domain/contracts/devise_repository.dart';
import 'package:mips/domain/entities/devise.dart';

class GetDeviseListUsecase {
  final DeviseRepository deviseRepository;

  const GetDeviseListUsecase({required this.deviseRepository});

  Future<Result<Failure, List<Devise>>> call() async {
    return deviseRepository.getDeviseList();
  }
}
