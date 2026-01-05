import 'package:MIPS/common/common.dart';
import 'package:MIPS/domain/contracts/avatar_repository.dart';

class BuyAvatarUseCase {
  final AvatarRepository avatarRepository;

  const BuyAvatarUseCase({
    required this.avatarRepository,
  });

  Future<Result<Failure, SuccessResult>> call(
      int id, int nombre, String moyenDePaiement) async {
    return avatarRepository.buyAvatar(id, nombre, moyenDePaiement);
  }
}
