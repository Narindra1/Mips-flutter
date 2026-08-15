import '../../../common/common.dart';
import '../../domain.dart';

class DeleteUserUseCase {
  final UserRepository userRepository;

  const DeleteUserUseCase({
    required this.userRepository,
  });

  Future<Result<Failure, SuccessResult>> call() async {
    return userRepository.deleteUser();
  }
}
