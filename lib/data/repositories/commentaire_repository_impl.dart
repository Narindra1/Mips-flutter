import 'package:mips/common/common.dart';
import 'package:mips/data/data.dart';
import 'package:mips/domain/domain.dart';

// Implémentation du dépôt pour la gestion des commentaires.
///
/// Utilise une source de données distante ([RemoteDataSource]) pour
/// récupérer, lister( avec pagination), créer, modifier ou supprimer les commentaires.
class CommentaireRepositoryImpl implements CommentaireRepository {
  final RemoteDataSource remoteDataSource;

  @override
  Future<Result<Failure, SuccessResult>> deleteCommentaire(
    String id,
    String idAnnonce,
  ) async {
    try {
      await remoteDataSource.deleteCommentaire(id, idAnnonce);
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
  Future<Result<Failure, List<Commentaire>>> getCommentairesByAnnonce(
    String annonceID,
    int page,
  ) async {
    try {
      List<Commentaire> result = (await remoteDataSource.fetchCommentaire(
        annonceID,
        page,
      )).map((e) => e.toEntity()).toList();
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
  Future<Result<Failure, Commentaire>> updateCommentaire(
    Commentaire commentaire,
  ) async {
    try {
      Commentaire result = (await remoteDataSource.updateCommentaire(
        CommentaireModel.fromEntity(commentaire),
      )).toEntity();
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

  const CommentaireRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Result<Failure, Commentaire>> createCommentaire(
    int idAnnonce,
    String content,
  ) async {
    try {
      Commentaire result = (await remoteDataSource.createCommentaire(
        idAnnonce,
        content,
      )).toEntity();

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
