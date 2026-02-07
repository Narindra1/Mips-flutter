import 'package:MIPS/domain/domain.dart';
import 'package:equatable/equatable.dart';

import '../../common/constants/constant.dart';
import '../../common/utils/app_utils.dart';
import 'commentaire.dart';

/// Entité représentant une annonce.
///
/// Contient toutes les informations relatives à une annonce, notamment :
/// - identifiants et titres ([id], [slug], [title])
/// - descriptions courte et détaillée ([descriptionCourte], [descriptionDetaille])
/// - localisation ([emplacement])
/// - contact et auteur ([contact], [author], [authorID])
/// - dates de création et limite ([dateDeCreation], [dateLimit])
/// - type d’annonce ([annonceType] :  { premium, sponsor, partenaire, general, vip })
/// - états favoris et likes ([isFavs], [isLiked])
/// - nombre de réactions ([reactionCount])
/// - photos associées ([photos])
/// - commentaires liés ([commentaires])
/// - informations sur le menu parent ([menuParentID], [menuParentRef], [menuParentName])
/// - numéro parrainage ([parrain])
/// - contenu HTML personnalisé ([customHtmlUrl])
/// - indique si c’est une publicité web ([isWebsitePub])
class Annonce extends Equatable {
  final int id;
  final String slug;
  final String title;
  final String descriptionCourte;
  final String emplacement;
  final String descriptionDetaille;
  final String contact;
  final String author;
  final int authorID;
  final String dateDeCreation;
  final String dateLimit;
  final AnnonceType annonceType;
  final bool canGetKaraBonus;
  final bool hasGetKaraBonus;
  final bool isFavs;
  final bool isLiked;
  final int reactionCount;
  final List<ImageEntity> photos;
  final List<Commentaire> commentaires;
  final int menuParentID;
  final String menuParentRef;
  final String menuParentName;
  final String menuRacineRef;
  final String menuRacineName;
  final String parrain;
  final String customHtmlUrl;
  final bool isWebsitePub;

  const Annonce(
      {required this.id,
      required this.slug,
      required this.title,
      required this.menuParentRef,
      required this.menuRacineRef,
      required this.menuRacineName,
      required this.descriptionCourte,
      required this.descriptionDetaille,
      required this.authorID,
      required this.photos,
      required this.isWebsitePub,
      required this.commentaires,
      required this.emplacement,
      required this.contact,
      required this.dateDeCreation,
      required this.annonceType,
      required this.author,
      required this.canGetKaraBonus,
      required this.hasGetKaraBonus,
      required this.isFavs,
      required this.isLiked,
      required this.dateLimit,
      required this.reactionCount,
      required this.menuParentID,
      required this.parrain,
      required this.customHtmlUrl,
      required this.menuParentName});

  @override
  List<Object> get props => [
        id,
        title,
        descriptionCourte,
        emplacement,
        descriptionDetaille,
        contact,
        author,
        menuRacineRef,
        menuRacineName,
        dateDeCreation,
        annonceType,
        canGetKaraBonus,
        hasGetKaraBonus,
        isFavs,
        photos,
        commentaires,
        menuParentID,
        menuParentName,
        reactionCount,
        isLiked,
        menuParentRef,
        slug
      ];

  Annonce copyWith({
    int? id,
    String? slug,
    String? title,
    String? descriptionCourte,
    String? emplacement,
    String? descriptionDetaille,
    String? contact,
    String? author,
    int? authorID,
    String? menuParentRef,
    String? menuRacineRef,
    String? menuRacineName,
    String? dateDeCreation,
    AnnonceType? annonceType,
    bool? canGetKaraBonus,
    bool? hasGetKaraBonus,
    bool? isFavs,
    bool? isLiked,
    int? reactionCount,
    List<ImageEntity>? photos,
    List<Commentaire>? commentaires,
    int? menuParentID,
    String? parrain,
    String? customHtmlUrl,
    String? menuParentName,
    String? dateLimit,
    bool? isWebsitePub,
  }) {
    return Annonce(
      id: id ?? this.id,
      slug: slug ?? this.slug,
      title: title ?? this.title,
      isWebsitePub: isWebsitePub ?? this.isWebsitePub,
      menuParentRef: menuParentRef ?? this.menuParentRef,
      descriptionCourte: descriptionCourte ?? this.descriptionCourte,
      emplacement: emplacement ?? this.emplacement,
      descriptionDetaille: descriptionDetaille ?? this.descriptionDetaille,
      contact: contact ?? this.contact,
      author: author ?? this.author,
      authorID: authorID ?? this.authorID,
      dateDeCreation: dateDeCreation ?? this.dateDeCreation,
      dateLimit: dateLimit ?? this.dateLimit,
      annonceType: annonceType ?? this.annonceType,
      canGetKaraBonus: canGetKaraBonus ?? this.canGetKaraBonus,
      hasGetKaraBonus: hasGetKaraBonus ?? this.hasGetKaraBonus,
      isFavs: isFavs ?? this.isFavs,
      isLiked: isLiked ?? this.isLiked,
      reactionCount: reactionCount ?? this.reactionCount,
      photos: photos ?? this.photos,
      parrain: parrain ?? this.parrain,
      customHtmlUrl: customHtmlUrl ?? this.customHtmlUrl,
      commentaires: commentaires ?? this.commentaires,
      menuParentID: menuParentID ?? this.menuParentID,
      menuParentName: menuParentName ?? this.menuParentName,
      menuRacineRef: menuRacineRef ?? this.menuRacineRef,
      menuRacineName: menuRacineName ?? this.menuRacineName,
    );
  }

  String get contactFormatted {
    return AppUtils.formatNumber(contact);
  }

  bool get isFree {
    return refFreeAnnonce.contains(menuParentRef);
  }
}
