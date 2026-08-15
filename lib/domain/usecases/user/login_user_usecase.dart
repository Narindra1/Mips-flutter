import '../../../common/common.dart';
import '../../domain.dart';

class LoginUserUseCase {
  final UserRepository userRepository;

  const LoginUserUseCase({
    required this.userRepository,
  });

  Future<Result<Failure, User>> call(
      String login, String password, bool stayLogged) async {
    return userRepository.loginUser(login, password, stayLogged);
  }
}
