import '../../../common/common.dart';
import '../../domain.dart';

class RegisterUserUseCase {
  final UserRepository userRepository;

  const RegisterUserUseCase({
    required this.userRepository,
  });

  Future<Result<Failure, User>> call(User user) async {
    return userRepository.registerUser(user);
  }
}
