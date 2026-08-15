import '../../../common/common.dart';
import '../../domain.dart';

class ChangePasswordUseCase {
  final UserRepository userRepository;

  const ChangePasswordUseCase({
    required this.userRepository,
  });

  Future<Result<Failure, User>> call(
      String oldPassword, String newPassword) async {
    return userRepository.changePassword(oldPassword, newPassword);
  }
}
