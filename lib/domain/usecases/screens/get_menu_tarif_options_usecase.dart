import 'package:mips/domain/domain.dart';

import '../../../common/common.dart';

class GetMenuTarifOptionsUseCase {
  final MenuRepository screenRepository;

  const GetMenuTarifOptionsUseCase({required this.screenRepository});

  Future<Result<Failure, List<AnnonceTarifOption>>> call(
    String idScreen,
  ) async {
    return screenRepository.getMenuAvaliability(idScreen);
  }
}
