import 'dart:typed_data';

import 'package:MIPS/domain/domain.dart';
import 'package:dio/dio.dart';

import '../../common/common.dart';

/// Interface définissant les opérations possibles sur les annonces.
///
/// Cette abstraction permet d'interagir avec les annonces, telles que :
///
/// - récupération des annonces par écran ou utilisateur,
/// - création, mise à jour, suppression d’une annonce,
/// - gestion des images associées aux annonces (upload, annulation),
/// - gestion des favoris et des réactions,
/// - prolongation de la validité d’une annonce,
/// - récupération d’une annonce popup.
///
/// Chaque méthode retourne un [Result] encapsulant un succès avec les données attendues,
/// ou une erreur représentée par un [Failure].
///
/// Les paramètres sont adaptés selon l’opération (ex : pagination, identifiants, fichiers).

abstract class AnnonceRepository {
  Future<Result<Failure, List<Annonce>>> getAllAnnoncesByScreenID(
      int id, int page, String query);

  Future<Result<Failure, List<Annonce>>> getUserAnnonces(
      int page, String query);

  Future<Result<Failure, int>> getUserAnnoncesCount();

  Future<Result<Failure, List<Annonce>>> getUserFavoriteAnnonces(
      int page, String query);

  Future<Result<Failure, int>> getUserFavoriteAnnoncesCount();

  Future<Result<Failure, Annonce>> getAnnonceByID(String annonceID);

  Future<Result<Failure, List<Annonce>>> getAnnonceByIDWithPartnerSponsor(
      String annonceID);

  Future<Result<Failure, List<Annonce>>> getRecentsAnnonces(
      int id, int page, String query);

  Future<Result<Failure, Annonce>> createAnnonce(
      Annonce annonce, int idTarifOptions);

  Future<Result<Failure, Annonce>> createAnnoncePlainteSuggestion(
      Annonce annonce, int idTarifOptions);

  Future<Result<Failure, ImageEntity>> uploadImageAnnonce(
      Uint8List imageByteList,
      String idMenu,
      Function(double progress /* value in precent */)? onProgress,
      CancelToken? cancelToken);

  Future<Result<Failure, bool>> cancelUploadImageAnnonce(
      ImageUpload imageUpload);

  Future<Result<Failure, Annonce>> updateAnnonce(Annonce annonceEntity);

  Future<Result<Failure, Annonce>> extendDateAnnonce(
      int idAnnonce, int idTariOptions);

  Future<Result<Failure, Annonce>> makeFavAnnonce(int id, bool isLike);

  Future<Result<Failure, Annonce>> reactAnnonce(int id, bool isLike);

  Future<Result<Failure, SuccessResult>> deleteAnnonce(String id);

  Future<Result<Failure, Annonce>> getPopUpAnnonce(bool isPair);
}
