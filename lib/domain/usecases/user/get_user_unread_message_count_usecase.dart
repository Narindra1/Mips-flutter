import '../../../common/common.dart';
import '../../domain.dart';

class GetUserUnreadMessageCountUsecase {
  final UserRepository userRepository;

  const GetUserUnreadMessageCountUsecase({
    required this.userRepository,
  });

  Future<Result<Failure, int>> call() async {
    return userRepository.getUserUnreadMessageCount();
  }
}
