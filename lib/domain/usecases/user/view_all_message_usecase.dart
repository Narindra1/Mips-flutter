import 'package:MIPS/common/common.dart';
import 'package:MIPS/domain/domain.dart';

class ViewAllMessageUseCase {
  final UserRepository userRepository;

  const ViewAllMessageUseCase({
    required this.userRepository,
  });

  Future<Result<Failure, SuccessResult>> call() {
    return userRepository.viewAllUserMessage();
  }
}
