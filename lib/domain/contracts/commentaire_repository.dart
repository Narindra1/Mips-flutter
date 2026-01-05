import 'package:MIPS/domain/domain.dart';

import '../../common/common.dart';

/// Interface pour la gestion des commentaires d’annonces.
///
/// Permet de :
/// - récupérer la liste des commentaires pour une annonce donnée ([getCommentairesByAnnonce]),
/// - créer un nouveau commentaire ([createCommentaire]),
/// - modifier un commentaire existant ([updateCommentaire]),
/// - supprimer un commentaire ([deleteCommentaire]).
///
/// Chaque méthode retourne un [Result] encapsulant un succès ou un [Failure]
/// en cas d'erreur réseau ou applicative.
abstract class CommentaireRepository {
  Future<Result<Failure, List<Commentaire>>> getCommentairesByAnnonce(
      String annonceID, int page);

  Future<Result<Failure, Commentaire>> updateCommentaire(
      Commentaire commentaire);

  Future<Result<Failure, Commentaire>> createCommentaire(
      int idAnnonce, String content);

  Future<Result<Failure, SuccessResult>> deleteCommentaire(
      String id, String idAnnonce);
}
