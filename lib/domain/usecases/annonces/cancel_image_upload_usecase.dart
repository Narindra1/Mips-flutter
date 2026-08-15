import 'package:mips/domain/domain.dart';

import '../../../common/common.dart';

class CancelImageUploadUseCase {
  final AnnonceRepository annonceRepository;

  const CancelImageUploadUseCase({required this.annonceRepository});

  Future<Result<Failure, bool>> call(ImageUpload imageUpload) async {
    return annonceRepository.cancelUploadImageAnnonce(imageUpload);
  }
}
