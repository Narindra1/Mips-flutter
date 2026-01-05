import '../../../common/common.dart';
import '../../domain.dart';

class ResetPasswordUseCase {
  final UserRepository userRepository;

  const ResetPasswordUseCase({
    required this.userRepository,
  });

  Future<Result<Failure, User>> call(
      String validationCode, String password) async {
    return userRepository.resetPassword(validationCode, password);
  }
}
