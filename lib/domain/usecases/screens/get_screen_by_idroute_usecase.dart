import 'package:mips/domain/domain.dart';

import '../../../common/common.dart';

class GetScreenByIDRouteUseCase {
  final MenuRepository screenRepository;

  const GetScreenByIDRouteUseCase({required this.screenRepository});

  Future<Result<Failure, Menu>> call(String idScreen) async {
    return screenRepository.getMenuById(idScreen);
  }
}
