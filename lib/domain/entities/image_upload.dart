import 'package:MIPS/domain/domain.dart';
import 'package:MIPS/domain/entities/image_entity.dart';
import 'package:dio/dio.dart';

/// Statut de l’upload d’une image.
enum ImageUploadStatus {
  uploaded, // Image uploadée avec succès
  error, // Erreur lors de l’upload
  uploading, // Upload en cours
}

/// Modèle représentant le processus d’upload d’une image.
///
/// Contient :
/// - l’entité image associée ([imageEntity])
/// - le token pour annuler l’upload ([cancelUploadToken])
/// - la progression actuelle de l’upload en pourcentage ([uploadProgress])
/// - la taille de l’image ([imageSize])
/// - le statut actuel de l’upload ([status])
class ImageUpload {
  ImageEntity imageEntity;
  CancelToken cancelUploadToken;
  double uploadProgress;
  double imageSize;
  ImageUploadStatus status;

  ImageUpload(
      {required this.imageEntity,
      required this.cancelUploadToken,
      required this.uploadProgress,
      required this.status,
      required this.imageSize});
}
