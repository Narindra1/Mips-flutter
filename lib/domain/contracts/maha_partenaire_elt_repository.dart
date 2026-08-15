import 'package:mips/domain/entities/maha_partenaire_elt.dart';
import '../../common/common.dart';

/// Interface pour la gestion des éléments du menu "MahaPartenaire".
///
/// Permet de récupérer la liste complète des éléments du menu partenaires
/// ([getAllMahaPartenaireElt]).
///
/// Retourne un [Result] encapsulant un succès ou un [Failure]
/// en cas d'erreur réseau ou applicative.
abstract class MahaPartenaireEltRepository {
  Future<Result<Failure, List<MahaPartenaireElt>>> getAllMahaPartenaireElt();
}
