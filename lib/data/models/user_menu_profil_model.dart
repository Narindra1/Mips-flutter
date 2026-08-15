import 'package:mips/data/data.dart';
import 'package:mips/domain/domain.dart';
import 'package:equatable/equatable.dart';

/// Modèle représentant le menu profil de l'utilisateur.
///
/// Champs :
/// - [annonceCount] : nombre total d'annonces de l'utilisateur.
/// - [menuFavoris] : liste des menus favoris de l'utilisateur.
/// - [annonceFavoris] : liste des annonces favorites de l'utilisateur.
///
class UserMenuProfilModel extends Equatable {
  final int annonceCount;
  final List<MenuItemModel> menuFavoris;
  final List<AnnonceModel> annonceFavoris;

  @override
  List<Object> get props => [annonceCount, menuFavoris, annonceFavoris];

  const UserMenuProfilModel({
    required this.annonceCount,
    required this.menuFavoris,
    required this.annonceFavoris,
  });

  Map<String, dynamic> toJson() {
    return {
      'annonceCount': this.annonceCount,
      'menuFavoris': this.menuFavoris,
      'annonceFavoris': this.annonceFavoris,
    };
  }

  factory UserMenuProfilModel.fromJson(Map<String, dynamic> jsonData) {
    List<MenuItemModel> menuFavs = [];
    List<AnnonceModel> annonceFavs = [];
    if (jsonData['menuFavoris'] != null) {
      menuFavs = (jsonData['menuFavoris'] as List<dynamic>)
          .map((value) => MenuItemModel.fromJson(value))
          .toList();
    }
    if (jsonData['annonceFavoris'] != null) {
      annonceFavs = (jsonData['annonceFavoris'] as List<dynamic>).map((value) {
        return AnnonceModel.fromJson(value);
      }).toList();
    }
    return UserMenuProfilModel(
      annonceCount: jsonData['publiciteCount'] as int,
      menuFavoris: menuFavs,
      annonceFavoris: annonceFavs,
    );
  }

  UserMenuProfilModel copyWith({
    int? annonceCount,
    List<MenuItemModel>? menuFavoris,
    List<AnnonceModel>? annonceFavoris,
  }) {
    return UserMenuProfilModel(
      annonceCount: annonceCount ?? this.annonceCount,
      menuFavoris: menuFavoris ?? this.menuFavoris,
      annonceFavoris: annonceFavoris ?? this.annonceFavoris,
    );
  }

  UserMenuProfil toEntity() {
    return UserMenuProfil(
      annonceCount: annonceCount,
      menuFavoris: menuFavoris.map((e) => e.toEntity()).toList(),
      annonceFavoris: annonceFavoris.map((e) => e.toEntity()).toList(),
    );
  }
}
