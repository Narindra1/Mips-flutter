import 'package:mips/domain/domain.dart';

import '../../common/common.dart';

/// Interface pour la gestion des menus de l'application.
///
/// Permet de :
/// - récupérer un menu par son ide  ([getMenuById]),
/// - aimer ou ne plus aimer un menu ([likeMenu]),
/// - récupérer la liste des menus parents ([getMenuParents]),
/// - récupérer les options de publication disponibles pour un menu ([getMenuAvaliability]).
///
/// Chaque méthode retourne un [Result] encapsulant un succès ou un [Failure]
/// en cas d'erreur réseau ou applicative.
abstract class MenuRepository {
  Future<Result<Failure, Menu>> getMenuById(String id);

  Future<Result<Failure, Menu>> likeMenu(String id, bool isLike);

  Future<Result<Failure, List<Menu>>> getMenuParents(String id);

  Future<Result<Failure, List<AnnonceTarifOption>>> getMenuAvaliability(
    String id,
  );
}
