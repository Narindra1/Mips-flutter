import 'package:mips/common/common.dart';
import 'package:mips/domain/entities/avis.dart';

/// Interface pour la gestion des avis utilisateur.
///
/// Permet de :
/// - récupérer la liste des avis disponibles ([getAvisList]),
/// - récupérer le détail d’un avis spécifique ([getAvis]).
///
/// Chaque méthode retourne un [Result] encapsulant un succès ou un [Failure]
/// en cas d'erreur réseau ou applicative.
abstract class AvisRepository {
  Future<Result<Failure, List<Avis>>> getAvisList();
  Future<Result<Failure, List<Avis>>> getMipsInfoList();
  Future<Result<Failure, Avis>> getAvis(int id);
}
