import 'package:mips/common/common.dart';
import 'package:mips/domain/domain.dart';
import 'package:mips/domain/entities/message.dart';

class GetUserMessages {
  final UserRepository userRepository;

  const GetUserMessages({required this.userRepository});

  Future<Result<Failure, List<Message>>> call(int page) {
    return userRepository.getUserMessages(page);
  }
}
