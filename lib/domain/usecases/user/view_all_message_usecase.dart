import 'package:mips/common/common.dart';
import 'package:mips/domain/domain.dart';

class ViewAllMessageUseCase {
  final UserRepository userRepository;

  const ViewAllMessageUseCase({required this.userRepository});

  Future<Result<Failure, SuccessResult>> call() {
    return userRepository.viewAllUserMessage();
  }
}
