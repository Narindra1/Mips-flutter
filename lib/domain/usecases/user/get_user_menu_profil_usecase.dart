import '../../../common/common.dart';
import '../../domain.dart';

class GetUserMenuProfilUseCase {
  final UserRepository userRepository;

  const GetUserMenuProfilUseCase({
    required this.userRepository,
  });

  Future<Result<Failure, UserMenuProfil>> call() async {
    return userRepository.getUserMenuProfil();
  }
}
