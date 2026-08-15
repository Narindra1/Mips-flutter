import 'package:mips/common/common.dart';
import 'package:mips/domain/domain.dart';

class DeleteAMessageUsecase {
  final UserRepository userRepository;

  const DeleteAMessageUsecase({required this.userRepository});

  Future<Result<Failure, SuccessResult>> call(int messageId) {
    return userRepository.deleteUserMessage(messageId);
  }
}
