import '../../../common/common.dart';
import '../../domain.dart';

class CheckPasswordUseCase {
  final UserRepository userRepository;

  const CheckPasswordUseCase({
    required this.userRepository,
  });

  Future<Result<Failure, SuccessResult>> call(String password) async {
    return userRepository.checkPassword(password);
  }
}
