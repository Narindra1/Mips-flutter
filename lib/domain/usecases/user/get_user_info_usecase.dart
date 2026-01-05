import '../../../common/common.dart';
import '../../domain.dart';

class GetUserInfoUseCase {
  final UserRepository userRepository;

  const GetUserInfoUseCase({
    required this.userRepository,
  });

  Future<Result<Failure, User>> call() async {
    return userRepository.getUserInfo();
  }
}
