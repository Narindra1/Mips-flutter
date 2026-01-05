import 'dart:typed_data';

import 'package:MIPS/domain/domain.dart';
import 'package:dio/dio.dart';

import '../../../common/common.dart';
import 'dart:io';

class UploadImageAnnonceUseCase {
  final AnnonceRepository annonceRepository;

  const UploadImageAnnonceUseCase({
    required this.annonceRepository,
  });

  Future<Result<Failure, ImageEntity>> call(
      File image,
      String idMenu,
      Function(double progress /* value in precent */)? onProgress,
      CancelToken? cancelToken) async {
    // Preprocessing task: Try to compress file before upload
    Uint8List imageByte = Uint8List(0);
    try {
      var result = await AppUtils.compressImageFile(image);
      if (result != null) {
        imageByte = result;
      }
    } catch (e) {
      AppUtils.showDebugLog(
          runtimeType, "$e Switch to adding uncompressed file");
      imageByte = image.readAsBytesSync();
    }
    return annonceRepository.uploadImageAnnonce(
        imageByte, idMenu, onProgress, cancelToken);
  }
}
