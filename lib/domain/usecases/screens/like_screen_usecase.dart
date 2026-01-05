import 'package:MIPS/domain/domain.dart';

import '../../../common/common.dart';

class LikeScreenUseCase {
  final MenuRepository screenRepository;

  const LikeScreenUseCase({
    required this.screenRepository,
  });

  Future<Result<Failure, Menu>> call(String idScreen, bool isLike) async {
    return screenRepository.likeMenu(idScreen, isLike);
  }
}
