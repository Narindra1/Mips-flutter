import 'package:mips/common/error/failures.dart';
import 'package:mips/common/result/results.dart';
import 'package:mips/domain/contracts/avatar_repository.dart';
import 'package:mips/domain/entities/avatar.dart';

class GetAvatarListUseCase {
  final AvatarRepository avatarRepository;

  const GetAvatarListUseCase({required this.avatarRepository});

  Future<Result<Failure, List<Avatar>>> call() async {
    return avatarRepository.getAvatarList();
  }
}
