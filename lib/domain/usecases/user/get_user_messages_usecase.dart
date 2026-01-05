import 'package:MIPS/common/common.dart';
import 'package:MIPS/domain/domain.dart';
import 'package:MIPS/domain/entities/message.dart';

class GetUserMessages {
  final UserRepository userRepository;

  const GetUserMessages({
    required this.userRepository,
  });

  Future<Result<Failure, List<Message>>> call(int page) {
    return userRepository.getUserMessages(page);
  }
}
