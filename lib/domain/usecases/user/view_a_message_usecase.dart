import 'package:MIPS/common/common.dart';
import 'package:MIPS/domain/domain.dart';

class ViewAMessageUseCase {
  final UserRepository userRepository;

  const ViewAMessageUseCase({
    required this.userRepository,
  });

  Future<Result<Failure, SuccessResult>> call(int messageId) {
    return userRepository.viewUserMessage(messageId);
  }
}
