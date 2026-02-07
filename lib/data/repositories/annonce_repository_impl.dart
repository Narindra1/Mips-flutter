import 'package:MIPS/common/common.dart';
import 'package:MIPS/data/data.dart';
import 'package:MIPS/domain/domain.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

/// Implémentation du dépôt pour gérer les annonces.
///
/// Ce service utilise une source de données distante ([RemoteDataSource])
/// pour effectuer les opérations CRUD sur les annonces, ainsi que des actions
/// comme la gestion des favoris, la publication, et le téléchargement d’images.
///
class AnnonceRepositoryImpl implements AnnonceRepository {
  final RemoteDataSource remoteDataSource;

  const AnnonceRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Result<Failure, List<Annonce>>> getAllAnnoncesByScreenID(
      int idScreen, int page, String query) async {
    try {
      List<Annonce> result =
          (await remoteDataSource.fetchAnnoncesByMenu(idScreen, page, query))
              .map((e) => e.toEntity())
              .toList();

      return Success(result);
    } on AppException catch (e) {
      AppUtils.showDebugLog(runtimeType, e.toString());
      if (e is NoConnectionException) {
        return Error(NoConnectionFailure());
      }
      return Error(ServerFailure(message: e.message));
    } on Exception catch (e) {
      return Error(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Result<Failure, SuccessResult>> getBonusFromAnnonce(
      int idAnnonce) async {
    try {
      await remoteDataSource.fetchBonusFromAnnonce(idAnnonce);
      return const Success(SuccessResult());
    } on AppException catch (e) {
      AppUtils.showDebugLog(runtimeType, e.toString());
      if (e is NoConnectionException) {
        return Error(NoConnectionFailure());
      }
      return Error(ServerFailure(message: e.message));
    } on Exception catch (e) {
      return Error(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Result<Failure, Annonce>> getAnnonceByID(String annonceID) async {
    try {
      Annonce result =
          (await remoteDataSource.fetchAnnonceById(annonceID)).toEntity();
      return Success(result);
    } on AppException catch (e) {
      AppUtils.showDebugLog(runtimeType, e.toString());
      if (e is NoConnectionException) {
        return Error(NoConnectionFailure());
      }
      return Error(ServerFailure(message: e.message));
    } on Exception catch (e) {
      return Error(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Result<Failure, List<Annonce>>> getAnnonceByIDWithPartnerSponsor(
      String annonceID) async {
    try {
      List<Annonce> result =
          (await remoteDataSource.fetchAnnonceByIdWithPartnerSponsor(annonceID))
              .map((e) => e.toEntity())
              .toList();
      return Success(result);
    } on AppException catch (e) {
      AppUtils.showDebugLog(runtimeType, e.toString());
      if (e is NoConnectionException) {
        return Error(NoConnectionFailure());
      }
      return Error(ServerFailure(message: e.message));
    } on Exception catch (e) {
      return Error(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Result<Failure, List<Annonce>>> getRecentsAnnonces(
      int idScreen, int page, String query) async {
    try {
      List<Annonce> result =
          (await remoteDataSource.fetchRecentsAnnonces(idScreen, page, query))
              .map((e) => e.toEntity())
              .toList();

      return Success(result);
    } on AppException catch (e) {
      AppUtils.showDebugLog(runtimeType, e.toString());
      if (e is NoConnectionException) {
        return Error(NoConnectionFailure());
      }
      return Error(ServerFailure(message: e.message));
    } on Exception catch (e) {
      return Error(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Result<Failure, Annonce>> extendDateAnnonce(
      int idAnnonce, int idTariOptions) async {
    try {
      Annonce result =
          (await remoteDataSource.extendValidity(idAnnonce, idTariOptions))
              .toEntity();
      return Success(result);
    } on AppException catch (e) {
      AppUtils.showDebugLog(runtimeType, e.toString());
      if (e is NoConnectionException) {
        return Error(NoConnectionFailure());
      }
      return Error(ServerFailure(message: e.message));
    } on Exception catch (e) {
      return Error(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Result<Failure, Annonce>> updateAnnonce(Annonce annonceEntity) async {
    try {
      Annonce result = (await remoteDataSource
              .updateAnnonce(AnnonceModel.fromEntity(annonceEntity)))
          .toEntity();
      return Success(result);
    } on AppException catch (e) {
      AppUtils.showDebugLog(runtimeType, e.toString());
      if (e is NoConnectionException) {
        return Error(NoConnectionFailure());
      }
      return Error(ServerFailure(message: e.message));
    } on Exception catch (e) {
      return Error(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Result<Failure, SuccessResult>> deleteAnnonce(String id) async {
    try {
      await remoteDataSource.deleteAnnonce(id);
      return const Success(SuccessResult());
    } on AppException catch (e) {
      AppUtils.showDebugLog(runtimeType, e.toString());
      if (e is NoConnectionException) {
        return Error(NoConnectionFailure());
      }
      return Error(ServerFailure(message: e.message));
    } on Exception catch (e) {
      return Error(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Result<Failure, Annonce>> createAnnonce(
      Annonce annonce, int idTarifOptions) async {
    try {
      Annonce result = (await remoteDataSource.createAnnonce(
              AnnonceModel.fromEntity(annonce), idTarifOptions))
          .toEntity();
      return Success(result);
    } on AppException catch (e) {
      AppUtils.showDebugLog(runtimeType, e.toString());
      if (e is NoConnectionException) {
        return Error(NoConnectionFailure());
      }
      return Error(ServerFailure(message: e.message));
    } on Exception catch (e) {
      return Error(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Result<Failure, Annonce>> createAnnoncePlainteSuggestion(
      Annonce annonce, int idTarifOptions) async {
    try {
      Annonce result = (await remoteDataSource.createAnnoncePlainteSuggestion(
              AnnonceModel.fromEntity(annonce), idTarifOptions))
          .toEntity();
      return Success(result);
    } on AppException catch (e) {
      AppUtils.showDebugLog(runtimeType, e.toString());
      if (e is NoConnectionException) {
        return Error(NoConnectionFailure());
      }
      return Error(ServerFailure(message: e.message));
    } on Exception catch (e) {
      return Error(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Result<Failure, ImageEntity>> uploadImageAnnonce(
      Uint8List imageByteList,
      String idMenu,
      Function(double progress /* value in precent */)? onProgress,
      CancelToken? cancelToken) async {
    try {
      ImageEntity result = (await remoteDataSource.uploadImage(
              imageByteList, idMenu, onProgress, cancelToken))
          .toEntity();
      return Success(result);
    } on AppException catch (e) {
      AppUtils.showDebugLog(runtimeType, e.toString());
      if (e is NoConnectionException) {
        return Error(NoConnectionFailure());
      }
      return Error(ServerFailure(message: e.message));
    } on Exception catch (e) {
      return Error(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Result<Failure, bool>> cancelUploadImageAnnonce(
      ImageUpload imageUpload) async {
    imageUpload.cancelUploadToken.cancel();
    return const Success(true);
  }

  @override
  Future<Result<Failure, int>> getUserAnnoncesCount() async {
    try {
      int result = await remoteDataSource.fetchUserAnnoncesCount();
      return Success(result);
    } on AppException catch (e) {
      AppUtils.showDebugLog(runtimeType, e.toString());
      if (e is NoConnectionException) {
        return Error(NoConnectionFailure());
      }
      return Error(ServerFailure(message: e.message));
    } on Exception catch (e) {
      return Error(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Result<Failure, int>> getUserFavoriteAnnoncesCount() async {
    try {
      int result = await remoteDataSource.fetchUserFavoriteAnnoncesCount();
      return Success(result);
    } on AppException catch (e) {
      AppUtils.showDebugLog(runtimeType, e.toString());
      if (e is NoConnectionException) {
        return Error(NoConnectionFailure());
      }
      return Error(ServerFailure(message: e.message));
    } on Exception catch (e) {
      return Error(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Result<Failure, Annonce>> makeFavAnnonce(int id, bool isLike) async {
    try {
      Annonce result =
          (await remoteDataSource.makeFavAnnonce(id, isLike)).toEntity();
      return Success(result);
    } on AppException catch (e) {
      AppUtils.showDebugLog(runtimeType, e.toString());
      if (e is NoConnectionException) {
        return Error(NoConnectionFailure());
      }
      return Error(ServerFailure(message: e.message));
    } on Exception catch (e) {
      return Error(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Result<Failure, List<Annonce>>> getUserAnnonces(
      int page, String query) async {
    try {
      List<Annonce> result =
          (await remoteDataSource.fetchAnnoncesUser(page, query))
              .map((e) => e.toEntity())
              .toList();
      return Success(result);
    } on AppException catch (e) {
      AppUtils.showDebugLog(runtimeType, e.toString());
      if (e is NoConnectionException) {
        return Error(NoConnectionFailure());
      }
      return Error(ServerFailure(message: e.message));
    } on Exception catch (e) {
      return Error(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Result<Failure, List<Annonce>>> getUserFavoriteAnnonces(
      int page, String query) async {
    try {
      List<Annonce> result =
          (await remoteDataSource.fetchUserFavoriteAnnonces(page, query))
              .map((e) => e.toEntity())
              .toList();
      return Success(result);
    } on AppException catch (e) {
      AppUtils.showDebugLog(runtimeType, e.toString());
      if (e is NoConnectionException) {
        return Error(NoConnectionFailure());
      }
      return Error(ServerFailure(message: e.message));
    } on Exception catch (e) {
      return Error(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Result<Failure, Annonce>> reactAnnonce(int id, bool isLike) async {
    try {
      Annonce result =
          (await remoteDataSource.reactAnnonce(id, isLike)).toEntity();
      return Success(result);
    } on AppException catch (e) {
      AppUtils.showDebugLog(runtimeType, e.toString());
      if (e is NoConnectionException) {
        return Error(NoConnectionFailure());
      }
      return Error(ServerFailure(message: e.message));
    } on Exception catch (e) {
      return Error(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Result<Failure, Annonce>> getPopUpAnnonce(bool isPair) async {
    try {
      Annonce result =
          (await remoteDataSource.fetchAnnoncePopup(isPair)).toEntity();
      return Success(result);
    } on AppException catch (e) {
      AppUtils.showDebugLog(runtimeType, e.toString());
      if (e is NoConnectionException) {
        return Error(NoConnectionFailure());
      }
      return Error(ServerFailure(message: e.message));
    } on Exception catch (e) {
      return Error(ServerFailure(message: e.toString()));
    }
  }
}
