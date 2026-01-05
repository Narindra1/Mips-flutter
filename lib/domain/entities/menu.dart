import 'dart:ui';

import 'package:MIPS/domain/domain.dart';

import '../../common/constants/constant.dart';

/// Entité représentant un menu (catégorie).
///
/// Contient :
/// - l’identifiant du menu ([id])
/// - le titre du menu ([title])
/// - la référence unique ([reference])
/// - indique si le menu est en favoris ([isFavs])
/// - indique si le menu est gratuit ([isFree])
/// - la liste des sous-menus enfants ([menusChildList])
/// - l’annonce sponsor associée ([annonceSponsor])
/// - l’annonce partenaire associée ([annoncePartner])
class Menu {
  final int id;
  final String title;
  final String reference;
  final bool isFavs;
  final bool isFree;
  final List<MenuItem> menusChildList;
  final Annonce? annonceSponsor;
  final Annonce? annoncePartner;

  const Menu(
      {required this.id,
      required this.title,
      required this.menusChildList,
      required this.isFree,
      required this.isFavs,
      required this.reference,
      required this.annoncePartner,
      required this.annonceSponsor});

  Menu copyWith(
      {int? id,
      String? title,
      String? reference,
      bool? isFavs,
      List<MenuItem>? element,
      bool? isBasicScreenWithoutPremium,
      Annonce? annonceSponsor,
      bool? isFree,
      Annonce? annoncePartner}) {
    return Menu(
        id: id ?? this.id,
        title: title ?? this.title,
        reference: reference ?? this.reference,
        isFavs: isFavs ?? this.isFavs,
        isFree: isFree ?? this.isFree,
        menusChildList: element ?? menusChildList,
        annoncePartner: annoncePartner ?? this.annonceSponsor,
        annonceSponsor: annonceSponsor ?? this.annonceSponsor);
  }
}

/// Entité représentant les sous-menu.
///
/// Contient :
/// - le nom du sous-menu ([name])
/// - le type de route associé ([screenTypeRoute])
/// - l’identifiant unique ([id])
/// - le nombre d’annonces du jour ([annoncesTodayCount])
/// - indique si l’élément est en favoris ([isFav])
/// - indique si l’élément est gratuit ([isFree])
/// - la description ([desc])
/// - la référence unique ([reference])
/// - la couleur associée (optionnelle) ([color])
/// - le chemin/url de l’icône (optionnel) ([iconPath])
/// - la liste des sous-éléments ([subMenu])
/// - le type d’élément de menu ([screenMenuItemType] : { menuMain, menuGroup, menuPopUp, menu, })
class MenuItem {
  final String name;
  final MenuTypeRoute screenTypeRoute;
  final int id;
  final int annoncesTodayCount;
  final bool isFav;
  final bool isFree;
  final String desc;
  final String reference;
  final Color? color;
  final String? iconPath;
  final int? nbrPartenaire;
  final List<MenuItem> subMenu;
  final MenuItemType screenMenuItemType;

  const MenuItem(
      {required this.name,
      required this.screenTypeRoute,
      required this.id,
      required this.desc,
      required this.reference,
      required this.isFav,
      required this.isFree,
      required this.annoncesTodayCount,
      this.nbrPartenaire,
      this.color,
      required this.subMenu,
      this.screenMenuItemType = MenuItemType.menu,
      this.iconPath});
}
