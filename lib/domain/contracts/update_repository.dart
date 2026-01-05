import 'package:MIPS/common/common.dart';

/// Interface pour la gestion des mises à jour de l’application.
///
/// Permet de vérifier si une mise à jour est disponible ([checkUpdate]).
///
/// La méthode retourne un [Result] encapsulant un succès avec la version disponible
/// (sous forme de [String]), ou un [Failure] en cas d'erreur réseau ou applicative.
abstract class UpdateRepository {
  Future<Result<Failure, String>> checkUpdate();
}
