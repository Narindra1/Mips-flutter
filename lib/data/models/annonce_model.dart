import 'package:mips/data/data.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';

import '../../common/constants/constant.dart';
import '../../common/utils/app_utils.dart';
import '../../common/services/environment_wrapper.dart';
import '../../domain/domain.dart';
import 'commentaire_model.dart';

/// Annonce modele responsable dans le deserialization depuis json
/// mapping : model vers entité  [Annonce] et entité vers model
class AnnonceModel extends Equatable {
  final int id;
  final String slug;
  final String title;
  final String descriptionCourte;
  final String emplacement;
  final String descriptionDetaille;
  final String contact;
  final String dateDeCreation;
  final String dateLimit;
  final String author;
  final String menuParentRef;
  final int authorID;
  final bool canGetKaraBonus;
  final bool hasGetKaraBonus;
  final bool isFavs;
  final bool isLiked;
  final bool isWebsitePub;
  final String customHtmlUrl;
  final int reactionCount;
  final List<ImageModel> photos;
  final List<CommentaireModel> commentaires;
  final AnnonceType annonceType;
  final String parrain;

  final int menuParentID;
  final String menuParentName;
  final String menuRacineRef;
  final String menuRacineName;

  const AnnonceModel({
    required this.id,
    required this.slug,
    required this.title,
    required this.descriptionCourte,
    required this.descriptionDetaille,
    required this.menuParentRef,
    required this.menuRacineRef,
    required this.menuRacineName,
    required this.photos,
    required this.isWebsitePub,
    required this.commentaires,
    required this.emplacement,
    required this.contact,
    required this.dateDeCreation,
    required this.dateLimit,
    required this.annonceType,
    required this.author,
    required this.authorID,
    required this.menuParentID,
    required this.menuParentName,
    required this.isLiked,
    required this.reactionCount,
    required this.customHtmlUrl,
    required this.parrain,
    required this.canGetKaraBonus,
    required this.hasGetKaraBonus,
    required this.isFavs,
  });

  factory AnnonceModel.fromJson(
    Map<String, dynamic> json, {
    AnnonceType? annonceType,
  }) {
    List<ImageModel> photoJson = [];
    AnnonceType annonceTypeRet = AnnonceType.general;
    if (annonceType == null) {
      if (json["type"] != null && (json["type"])["nom"] != null) {
        switch ((json["type"])["nom"]) {
          case "PREMIUM":
            annonceTypeRet = AnnonceType.premium;
            break;
          case "SPONSOR":
            annonceTypeRet = AnnonceType.sponsor;
            break;
          case "PARTENAIRE":
            annonceTypeRet = AnnonceType.partenaire;
            break;
          case "VIP":
            annonceTypeRet = AnnonceType.vip;
            break;
          case "GENERAL":
          default:
            annonceTypeRet = AnnonceType.general;
        }
      }
    } else {
      annonceTypeRet = annonceType;
    }
    if (json["images"] != null &&
        (json["images"] as List<dynamic>).isNotEmpty) {
      for (var image in (json["images"] as List<dynamic>)) {
        if (image['url'] != null &&
            image['url'] != "photo1.png" &&
            image['url'] != "photo2.png" &&
            image['url'] != "photo3.png") {
          photoJson.add(ImageModel.fromJson(image));
        }
      }
    } else {
      /* photoJson.add(const ImageModel(
          id: 0,
          url: defaultAnnonceEmptyImageUrl,
          urlMiniature: defaultAnnonceEmptyImageUrl));*/
    }
    int menuParentID = 0;
    String menuParentName = "Menu";
    String menuParentRef = "0";
    String menuRacineRef = "";
    String menuRacineName = "";

    print("MENU PARENT: ${json["menu_parent"]}");

    if (json["menu_parent"] != null) {
      menuParentID = (json["menu_parent"])["id"];
      menuParentName = (json["menu_parent"])["nom"];
      menuParentRef = (json["menu_parent"])["reference"];
    }
    if (json["menu_racine"] != null) {
      menuRacineRef = (json["menu_racine"])["reference"];
      menuRacineName = (json["menu_racine"])["nom"];
    }

    // Parse commentaire
    List<CommentaireModel> commentaires = [];
    if (json["commentaires"] != null &&
        (json["commentaires"] as List).isNotEmpty) {
      commentaires = (json["commentaires"] as List).map((e) {
        return CommentaireModel.fromJson(e);
      }).toList();
    }
    String website_url = "";
    if (json["website_url"] != null) {
      if (json["website_url"].toString().startsWith('/')) {
        website_url = json["website_url"].toString().substring(1);
      } else {
        website_url = json["website_url"].toString();
      }
    } else {
      website_url = "";
    }
    return AnnonceModel(
      menuParentID: menuParentID,
      menuParentName: menuParentName,
      menuParentRef: menuParentRef,
      menuRacineRef: menuRacineRef,
      menuRacineName: menuRacineName,
      id: json["id"] ?? 0,
      isWebsitePub: (json["is_website_pub"] ?? 0) == 1,
      slug: json["slug"] ?? "slug",
      title: json["titre"] ?? "",
      dateLimit: json["limited_date"] ?? "",
      customHtmlUrl:
          (GetIt.instance<EnvironmentWrapper>().baseUrl + website_url),
      photos: photoJson,
      isLiked: json["hasLike"] ?? false,
      reactionCount: json["reactions_count"] ?? -1,
      descriptionCourte: json['description_courte'] ?? "",
      descriptionDetaille: json['description_detaille'] ?? "",
      emplacement: json['lieu'] ?? "",
      contact: json['contact'] ?? "",
      commentaires: commentaires,
      parrain: json['parrain'] ?? "",
      canGetKaraBonus: json["canGetKaraBonus"] ?? false,
      hasGetKaraBonus: json["hasGetKaraBonus"] ?? false,
      isFavs: json["hasFavourite"] ?? false,
      annonceType: annonceTypeRet,
      author: json["auteur_basic"] == null
          ? "User"
          : (json["auteur_basic"])["pseudo"] ?? "User",
      authorID: json["auteur_basic"] == null
          ? 0
          : (json["auteur_basic"])["id"] ?? 0,
      dateDeCreation: json['created_at'] ?? "",
    );
  }

  Annonce toEntity() {
    return Annonce(
      dateLimit: dateLimit,
      menuParentID: menuParentID,
      menuParentName: menuParentName,
      menuParentRef: menuParentRef,
      menuRacineRef: menuRacineRef,
      menuRacineName: menuRacineName,
      isWebsitePub: isWebsitePub,
      id: id,
      slug: slug,
      title: title,
      customHtmlUrl: customHtmlUrl,
      descriptionCourte: descriptionCourte,
      descriptionDetaille: descriptionDetaille,
      contact: AppUtils.sanitizeNumber(contact),
      dateDeCreation: dateDeCreation,
      emplacement: emplacement,
      photos: photos.map((e) => e.toEntity()).toList(),
      author: author,
      authorID: authorID,
      isLiked: isLiked,
      parrain: parrain,
      reactionCount: reactionCount,
      annonceType: annonceType,
      commentaires: commentaires.map((e) => e.toEntity()).toList(),
      canGetKaraBonus: canGetKaraBonus,
      hasGetKaraBonus: hasGetKaraBonus,
      isFavs: isFavs,
    );
  }

  factory AnnonceModel.fromEntity(Annonce annonce) {
    return AnnonceModel(
      dateLimit: annonce.dateLimit,
      menuParentName: annonce.menuParentName,
      menuParentID: annonce.menuParentID,
      menuParentRef: annonce.menuParentRef,
      menuRacineRef: annonce.menuRacineRef,
      menuRacineName: annonce.menuRacineName,
      isWebsitePub: annonce.isWebsitePub,
      id: annonce.id,
      slug: annonce.slug,
      parrain: annonce.parrain,
      customHtmlUrl: annonce.customHtmlUrl,
      title: annonce.title,
      isLiked: annonce.isLiked,
      reactionCount: annonce.reactionCount,
      descriptionCourte: annonce.descriptionCourte,
      descriptionDetaille: annonce.descriptionDetaille,
      contact: annonce.contact,
      emplacement: annonce.emplacement,
      dateDeCreation: annonce.dateDeCreation,
      photos: annonce.photos.map((e) => ImageModel.fromEntity(e)).toList(),
      canGetKaraBonus: annonce.canGetKaraBonus,
      hasGetKaraBonus: annonce.hasGetKaraBonus,
      isFavs: annonce.isFavs,
      author: annonce.author,
      authorID: annonce.authorID,
      annonceType: annonce.annonceType,
      commentaires: annonce.commentaires
          .map((e) => CommentaireModel.fromEntity(e))
          .toList(),
    );
  }

  @override
  List<Object> get props => [
    id,
    title,
    descriptionCourte,
    photos,
    commentaires,
    isLiked,
    reactionCount,
  ];

  AnnonceModel copyWith({
    int? id,
    String? title,
    String? descriptionCourte,
    String? emplacement,
    String? descriptionDetaille,
    String? contact,
    String? dateDeCreation,
    String? menuRacineRef,
    String? menuRacineName,
    String? dateLimit,
    bool? canGetKaraBonus,
    bool? hasGetKaraBonus,
    bool? isFavs,
    bool? isWebsitePub,
    List<ImageModel>? photos,
    List<CommentaireModel>? commentaires,
    List<String>? photoJson,
    List<String>? photoUrlList,
    String? author,
    int? authorID,
    int? menuParentID,
    String? menuParentRef,
    String? slug,
    String? menuParentName,
    bool? isLiked,
    String? parrain,
    String? customHtmlUrl,
    int? reactionCount,
    AnnonceType? annonceType,
  }) {
    return AnnonceModel(
      menuRacineRef: menuRacineRef ?? this.menuRacineRef,
      menuRacineName: menuRacineName ?? this.menuRacineName,
      dateLimit: dateLimit ?? this.dateLimit,
      menuParentName: menuParentName ?? this.menuParentName,
      menuParentID: menuParentID ?? this.menuParentID,
      menuParentRef: menuParentRef ?? this.menuParentRef,
      isWebsitePub: isWebsitePub ?? this.isWebsitePub,
      id: id ?? this.id,
      slug: slug ?? this.slug,
      title: title ?? this.title,
      customHtmlUrl: customHtmlUrl ?? this.customHtmlUrl,
      parrain: parrain ?? this.parrain,
      descriptionCourte: descriptionCourte ?? this.descriptionCourte,
      emplacement: emplacement ?? this.emplacement,
      descriptionDetaille: descriptionDetaille ?? this.descriptionDetaille,
      contact: contact ?? this.contact,
      dateDeCreation: dateDeCreation ?? this.dateDeCreation,
      canGetKaraBonus: canGetKaraBonus ?? this.canGetKaraBonus,
      hasGetKaraBonus: hasGetKaraBonus ?? this.hasGetKaraBonus,
      isFavs: isFavs ?? this.isFavs,
      photos: photos ?? this.photos,
      author: author ?? this.author,
      authorID: authorID ?? this.authorID,
      annonceType: annonceType ?? this.annonceType,
      commentaires: commentaires ?? this.commentaires,
      isLiked: isLiked ?? this.isLiked,
      reactionCount: reactionCount ?? this.reactionCount,
    );
  }

  Map<String, dynamic> toJson() {
    List<int> imagesID = photos.map((e) => e.id).toList();

    return {
      'id': id,
      'titre': title,
      'description_courte': descriptionCourte.isEmpty ? "." : descriptionCourte,
      'lieu': emplacement,
      'description_detaille': descriptionDetaille,
      'contact': contact.replaceAll(" ", ""),
      'auteur_id': "1",
      'imagesId': imagesID.isEmpty ? [0] : imagesID,
      'menus_id': menuParentID,
      'parrain': parrain,

      /// IMPORTANT: Annonce type ID: his index is hardcoded into Enum values AnnonceModelType
      'type_id': annonceType.index + 1,
    };
  }
}
