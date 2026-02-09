import 'package:MIPS/common/common.dart';
import 'package:MIPS/domain/domain.dart';

class DeleteAllMessageUsecase {
  final UserRepository userRepository;

  const DeleteAllMessageUsecase({
    required this.userRepository,
  });

  Future<Result<Failure, SuccessResult>> call() {
    return userRepository.deleteAllUserMessage();
  }
}
