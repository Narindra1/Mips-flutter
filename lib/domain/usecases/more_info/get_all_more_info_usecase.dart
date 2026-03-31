import 'package:MIPS/common/common.dart';
import 'package:MIPS/domain/contracts/more_info_repository.dart';
import 'package:MIPS/domain/entities/more_info.dart';

class GetAllMoreInfoUsecase {
  final MoreInfoRepository moreInfoRepository;

  const GetAllMoreInfoUsecase({
    required this.moreInfoRepository,
  });

  Future<Result<Failure, List<MoreInfo>>> call() async {
    return moreInfoRepository.getMoreInfoList();
  }
}
