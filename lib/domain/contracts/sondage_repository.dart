import 'package:mips/common/common.dart';
import 'package:mips/domain/entities/sondage.dart';

/// Interface pour la gestion des sondages.
///
/// Permet de :
/// - récupérer la liste des sondages disponibles ([getAllSondage]),
/// - soumettre une réponse à un sondage ([submitSondage]).
///
/// Chaque méthode retourne un [Result] encapsulant un succès ou un [Failure]
/// en cas d'erreur réseau ou applicative.
abstract class SondageRepository {
  Future<Result<Failure, List<Sondage>>> getAllSondage();

  Future<Result<Failure, Sondage>> submitSondage(
    int idSondage,
    int idResponseOption,
  );
}
