import 'package:mips/common/common.dart';
import 'package:mips/data/data.dart';
import 'package:mips/domain/contracts/annonce_repository.dart';
import 'package:mips/domain/domain.dart';

class GetAnnoncePopupUseCase {
  final AnnonceRepository annonceRepository;
  final UserPrefRepositoryImpl userPrefRepository;

  const GetAnnoncePopupUseCase({
    required this.annonceRepository,
    required this.userPrefRepository,
  });

  Future<Result<Failure, Annonce>> call() async {
    int count = userPrefRepository.getLaunchCount();
    return annonceRepository.getPopUpAnnonce(count % 2 == 0);
  }
}
