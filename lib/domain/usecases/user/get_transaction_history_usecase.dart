import 'package:MIPS/common/common.dart';
import 'package:MIPS/domain/domain.dart';

class GetTransactionHistoryUsecase {
  final UserRepository userRepository;

  const GetTransactionHistoryUsecase({
    required this.userRepository,
  });

  Future<Result<Failure, List<TransactionHistory>>> call(int page) {
    return userRepository.getTransactionHistory(page);
  }
}
