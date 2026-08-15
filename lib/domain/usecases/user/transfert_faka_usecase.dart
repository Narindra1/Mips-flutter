import '../../../common/error/failures.dart';
import '../../../common/result/results.dart';
import '../../contracts/user_repository.dart';
import '../../entities/user.dart';

class TransfertFakaUseCase {
  final UserRepository userRepository;

  const TransfertFakaUseCase({
    required this.userRepository,
  });

  Future<Result<Failure, User>> call(
      String phoneReceiver, int amount, String motif) async {
    return userRepository.transfertFaka(phoneReceiver, amount, motif);
  }
}
