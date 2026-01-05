import '../../../common/common.dart';
import '../../domain.dart';

class ForgotPasswordUseCase {
  final UserRepository userRepository;

  const ForgotPasswordUseCase({
    required this.userRepository,
  });

  Future<Result<Failure, SuccessResult>> call(String email) async {
    return userRepository.forgotPassword(email);
  }
}
