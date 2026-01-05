import 'package:MIPS/domain/domain.dart';
import 'package:equatable/equatable.dart';

/// Entité représentant le profil de menu de l'utilisateur.
///
/// Contient :
/// - le nombre d'annonces publiées par l'utilisateur ([annonceCount])
/// - la liste des menus favoris de l'utilisateur ([menuFavoris])
/// - la liste des annonces favorites de l'utilisateur ([annonceFavoris])

class UserMenuProfil extends Equatable {
  final int annonceCount;
  final List<MenuItem> menuFavoris;
  final List<Annonce> annonceFavoris;

  @override
  List<Object> get props => [
        annonceCount,
        menuFavoris,
        annonceFavoris,
      ];

  const UserMenuProfil({
    required this.annonceCount,
    required this.menuFavoris,
    required this.annonceFavoris,
  });

  UserMenuProfil copyWith({
    int? annonceCount,
    List<MenuItem>? menuFavoris,
    List<Annonce>? annonceFavoris,
  }) {
    return UserMenuProfil(
      annonceCount: annonceCount ?? this.annonceCount,
      menuFavoris: menuFavoris ?? this.menuFavoris,
      annonceFavoris: annonceFavoris ?? this.annonceFavoris,
    );
  }
}
