import 'package:mips/common/common.dart';
import 'package:mips/domain/domain.dart';

class DeleteAllMessageUsecase {
  final UserRepository userRepository;

  const DeleteAllMessageUsecase({required this.userRepository});

  Future<Result<Failure, SuccessResult>> call() {
    return userRepository.deleteAllUserMessage();
  }
}
