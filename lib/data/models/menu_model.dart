import 'dart:ui';

import 'package:MIPS/data/data.dart';
import 'package:MIPS/domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';

import '../../common/constants/constant.dart';
import '../../common/services/environment_wrapper.dart';

/// Model pour les menus (categories) dans l'app
/// ex: Quotidien, Vehicules ...
///
/// Champs :
/// - [id] : identifiant unique du menu.
/// - [reference] : référence unique du menu.
/// - [title] : titre  du menu.
/// - [desc] : description du menu.
/// - [isFavs] : indique si ce menu est marqué comme favori par l'utilisateur.
/// - [isFree] : indique si la publication des annonces dans le menu sont gratuit.
/// - [menusChild] : liste des sous-menus  associées.
/// - [annonceSponsor] : annonce sponsorisée associée au menu (si disponible).
/// - [annoncePartner] : annonce partenaire associée au menu (si disponible).
class MenuModel extends Equatable {
  final int id;
  final String reference;
  final String title;
  final String desc;
  final bool isFavs;
  final bool isFree;
  final List<MenuItemModel> menusChild;
  final AnnonceModel? annonceSponsor;
  final AnnonceModel? annoncePartner;

  const MenuModel(
      {required this.id,
      required this.title,
      required this.desc,
      required this.menusChild,
      required this.reference,
      required this.isFree,
      required this.annonceSponsor,
      required this.annoncePartner,
      required this.isFavs});

  factory MenuModel.fromJson(Map<String, dynamic> screenJson) {
    List<MenuItemModel> elements = [];
    AnnonceModel? annonceSpons;
    AnnonceModel? annoncePart;
    if (screenJson["annonces"] != null) {
      if ((screenJson["annonces"])["SPONSOR"] != null) {
        annonceSpons =
            AnnonceModel.fromJson((screenJson["annonces"])["SPONSOR"]);
      }
      if ((screenJson["annonces"])["PARTENAIRE"] != null) {
        annoncePart =
            AnnonceModel.fromJson((screenJson["annonces"])["PARTENAIRE"]);
      }
    }
    if (screenJson["hasLike"] == null) {
      Map<String, dynamic>? menu = screenJson["menus"];

      /// Si [menu] est nul, cela signifie le menu principal.
      if (menu != null) {
        if (screenJson["sous-menus"] != null) {
          for (var screenElement in screenJson["sous-menus"]) {
            elements.add(MenuItemModel.fromJson(screenElement));
          }
        }

        return MenuModel(
            id: menu["id"],
            reference: menu["reference"],
            title: menu["nom"],
            isFree: ((menu["is_free"]) ?? 0) == 1,
            desc: menu["description"] ?? "",
            isFavs: menu["hasLike"] ?? false,
            annoncePartner: annoncePart,
            annonceSponsor: annonceSpons,
            menusChild: elements);
      } else {
        if (screenJson["sous-menus"] != null) {
          for (var screenElement in screenJson["sous-menus"]) {
            elements
                .add(MenuItemModel.fromJson(screenElement, isMainMenu: true));
          }
        }
        return MenuModel(
            id: screenJson["id"] ?? 0,
            desc: screenJson["description"] ?? "",
            reference: screenJson["reference"] ?? "0000",
            title: screenJson["nom"] ?? "Mahafaka",
            isFree: ((screenJson["is_free"]) ?? 0) == 1,
            menusChild: elements,
            isFavs: false,
            annoncePartner: annoncePart,
            annonceSponsor: annonceSpons);
      }
    }

    /// Données provenant de l'action de mise à jour ou de mise en favori.
    else {
      return MenuModel(
          id: screenJson["id"] ?? 0,
          reference: screenJson["reference"] ?? "0000",
          desc: screenJson["description"] ?? "",
          isFree: ((screenJson["is_free"]) ?? 0) == 1,
          title: screenJson["nom"] ?? "Mahafaka",
          menusChild: elements,
          isFavs: screenJson["hasLike"] ?? false,
          annonceSponsor: annonceSpons,
          annoncePartner: annoncePart);
    }
  }

  Menu toEntity() {
    return Menu(
        id: id,
        title: title,
        reference: reference,
        menusChildList: menusChild.map((e) => e.toEntity()).toList(),
        isFavs: isFavs,
        isFree: isFree,
        annonceSponsor: annonceSponsor?.toEntity(),
        annoncePartner: annoncePartner?.toEntity());
  }

  @override
  List<Object> get props => [id, title, menusChild, reference];
}

/// Modèle représentant un élément de menu (sous-catégorie ou entrée de menu).
///
/// Champs :
/// - [name] : nom de l'élément de menu.
/// - [menuTypeRoute] : type de navigation associé à ce menu.
/// - [id] : identifiant unique de l'élément.
/// - [annoncesTodayCount] : nombre d'annonces publiées aujourd'hui pour ce menu.
/// - [desc] : description de l'élément de menu.
/// - [isFav] : indique si cet élément est marqué comme favori.
/// - [isFree] : indique si cet élément est accessible gratuitement.
/// - [reference] : référence technique de l'élément.
/// - [color] : couleur associée au menu (optionnelle).
/// - [iconPath] : chemin de l'icône associée (optionnel).
/// - [subMenu] : liste des sous-menus éventuels.
/// - [menuItemType] : type de l'élément de menu. {menuMain, menuGroup, menuPopUp, menu}
class MenuItemModel extends Equatable {
  final String name;
  final MenuTypeRoute menuTypeRoute;
  final int id;
  final int annoncesTodayCount;
  final String desc;
  final bool isFav;
  final bool isFree;
  final String reference;
  final Color? color;
  final String? iconPath;
  final List<MenuItemModel> subMenu;
  final MenuItemType menuItemType;

  const MenuItemModel(
      {required this.name,
      required this.menuTypeRoute,
      required this.id,
      required this.isFav,
      required this.isFree,
      required this.reference,
      required this.desc,
      required this.annoncesTodayCount,
      this.color,
      this.subMenu = const [],
      this.menuItemType = MenuItemType.menu,
      this.iconPath});

  factory MenuItemModel.fromJson(Map<String, dynamic> screenMenuItemJson,
      {bool isMainMenu = false}) {
    MenuItemType menuItemType = MenuItemType.menu;
    if (isMainMenu) {
      menuItemType = MenuItemType.menuMain;
    } else {
      if (screenMenuItemJson["type_basic"] != null) {
        var menuType = (screenMenuItemJson["type_basic"])["nom"];
        switch (menuType) {
          case "mainMenu":
            menuItemType = MenuItemType.menuMain;
            break;
          case "VOYAGE":
            menuItemType = MenuItemType.menuGroup;
            break;
          case "POPUP":
            menuItemType = MenuItemType.menuPopUp;
            break;
          case "GROUP":
            menuItemType = MenuItemType.menuGroup;
            break;
          default:
            menuItemType = MenuItemType.menu;
        }
      }
    }

    MenuTypeRoute menuTypeRoute = MenuTypeRoute.menuScroll;
    if (screenMenuItemJson["content_type_basic"] != null) {
      String contentName = (screenMenuItemJson["content_type_basic"])["nom"];
      // final String referenceIM = screenMenuItemJson["reference"] ?? "0000";
      switch (contentName) {
        case "ANNONCE":
          menuTypeRoute = MenuTypeRoute.list;
          break;
        case "ANNONCE_BASIC":
          menuTypeRoute = MenuTypeRoute.listBasic;
          break;
        case "MENU":
          menuTypeRoute = MenuTypeRoute.menuScroll;
          break;
        case "MAHA_SONDAGE":
          menuTypeRoute = MenuTypeRoute.MAHA_SONDAGE;
          break;
        case "MAHA_PARTENAIRE":
          menuTypeRoute = MenuTypeRoute.MAHA_PARTENAIRE;
          break;
        case "MAHA_PLAINTE_SUGGESTION":
          menuTypeRoute = MenuTypeRoute.MAHA_PLAINTE_SUGGESTION;
          break;
        case "MAHA_AVIS":
          menuTypeRoute = MenuTypeRoute.MAHA_AVIS;
          break;
        case "EXCHANGE_RATE":
          menuTypeRoute = MenuTypeRoute.EXCHANGE_RATE;
          break;
        case "KARA_PARTNER":
          menuTypeRoute = MenuTypeRoute.KARA_PARTNER;
          break;
        case "MIPS_INFO":
          menuTypeRoute = MenuTypeRoute.MIPS_INFO;
          break;
        default:
          menuTypeRoute = MenuTypeRoute.none;
          break;
      }
    } else {
      menuTypeRoute = MenuTypeRoute.list;
    }
    List<MenuItemModel> listsubItem = [];
    if (screenMenuItemJson["child"] != null) {
      listsubItem = (screenMenuItemJson["child"] as List<dynamic>)
          .map((e) => MenuItemModel.fromJson(e))
          .toList();
    }
    return MenuItemModel(
        name: screenMenuItemJson["nom"] ?? "",
        desc: screenMenuItemJson["description"] ?? "",
        annoncesTodayCount: screenMenuItemJson["annoncesTodayCount"] ?? 0,
        isFav: screenMenuItemJson["hasLike"] ?? false,
        isFree: ((screenMenuItemJson["is_free"]) ?? 0) == 1,
        menuItemType: menuItemType,
        reference: screenMenuItemJson["reference"] ?? "0000",
        menuTypeRoute: menuTypeRoute,
        id: screenMenuItemJson["id"] ?? 0,
        iconPath: (screenMenuItemJson["url_icon"] != null &&
                screenMenuItemJson["url_icon"] != "")
            ? GetIt.instance<EnvironmentWrapper>().baseUrl +
                // '/' +
                (screenMenuItemJson["url_icon"])
            : null,
        subMenu: listsubItem);
  }

  MenuItem toEntity() {
    MenuItemType screenElementItemType = MenuItemType.menu;
    switch (menuItemType) {
      case MenuItemType.menuMain:
        screenElementItemType = MenuItemType.menuMain;
        break;
      case MenuItemType.menuGroup:
        screenElementItemType = MenuItemType.menuGroup;
        break;
      case MenuItemType.menuPopUp:
        screenElementItemType = MenuItemType.menuPopUp;
        break;
      case MenuItemType.menu:
        screenElementItemType = MenuItemType.menu;
    }
    return MenuItem(
        name: name,
        desc: desc,
        annoncesTodayCount: annoncesTodayCount,
        screenTypeRoute: menuTypeRoute,
        isFav: isFav,
        isFree: isFree,
        id: id,
        reference: reference,
        screenMenuItemType: screenElementItemType,
        iconPath: iconPath,
        color: color,
        subMenu: (subMenu.map((e) => e.toEntity()).toList()));
  }

  @override
  List<Object?> get props => [
        name,
        menuTypeRoute,
        id,
        color,
        iconPath,
        subMenu,
        menuItemType,
      ];
}
