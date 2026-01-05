import 'package:MIPS/common/error/failures.dart';
import 'package:MIPS/common/result/results.dart';
import 'package:MIPS/domain/contracts/avatar_repository.dart';
import 'package:MIPS/domain/entities/avatar.dart';

class GetAvatarListUseCase {
  final AvatarRepository avatarRepository;

  const GetAvatarListUseCase({
    required this.avatarRepository,
  });

  Future<Result<Failure, List<Avatar>>> call() async {
    return avatarRepository.getAvatarList();
  }
}
