import 'package:MIPS/common/common.dart';
import 'package:MIPS/domain/domain.dart';

class DeleteAMessageUsecase {
  final UserRepository userRepository;

  const DeleteAMessageUsecase({
    required this.userRepository,
  });

  Future<Result<Failure, SuccessResult>> call(int messageId) {
    return userRepository.deleteUserMessage(messageId);
  }
}
