import 'package:mips/common/common.dart';
import 'package:mips/domain/entities/avatar.dart';

/// Interface pour la gestion des avatars utilisateur.
///
/// Permet de :
/// - récupérer la liste des avatars disponibles ([getAvatarList]),
/// - acheter un avatar ([buyAvatar]).
///
/// Chaque méthode retourne un [Result] encapsulant un succès ou un [Failure]
/// en cas d'erreur réseau ou applicative.
abstract class AvatarRepository {
  Future<Result<Failure, List<Avatar>>> getAvatarList();

  Future<Result<Failure, SuccessResult>> buyAvatar(
    int id,
    int nombre,
    String moyenDePaiement,
  );
}
