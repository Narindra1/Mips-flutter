import '../../../common/common.dart';
import '../../domain.dart';

class LogoutUserUseCase {
  final UserRepository userRepository;

  const LogoutUserUseCase({
    required this.userRepository,
  });

  Future<Result<Failure, SuccessResult>> call() async {
    return userRepository.logoutUser();
  }
}
