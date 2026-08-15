import '../../../common/common.dart';
import '../../domain.dart';

class UpdateUserUseCase {
  final UserRepository userRepository;

  const UpdateUserUseCase({
    required this.userRepository,
  });

  Future<Result<Failure, User>> call(User user) async {
    return userRepository.updateUser(user);
  }
}
