import 'package:mips/domain/domain.dart';

import '../../../common/common.dart';

class GetParentMenuScreenUseCase {
  final MenuRepository screenRepository;

  const GetParentMenuScreenUseCase({required this.screenRepository});

  Future<Result<Failure, List<Menu>>> call(String idScreen) async {
    return screenRepository.getMenuParents(idScreen);
  }
}
