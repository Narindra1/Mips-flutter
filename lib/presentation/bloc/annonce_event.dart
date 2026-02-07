part of 'annonce_bloc.dart';

sealed class AnnonceEvent {
  const AnnonceEvent();
}

class LoadAnnonceList extends AnnonceEvent {
  final int id;
  final int pageIndex;

  const LoadAnnonceList({required this.id, required this.pageIndex});
}

class LoadRecentAnnonceList extends AnnonceEvent {
  final int id;
  final int pageIndex;

  const LoadRecentAnnonceList({required this.id, required this.pageIndex});
}

class GetBonusFromAnnonceEvent extends AnnonceEvent {
  final int idAnnonce;

  const GetBonusFromAnnonceEvent({
    required this.idAnnonce,
  });
}

class LoadAnnonce extends AnnonceEvent {
  final String id;

  const LoadAnnonce({
    required this.id,
  });
}

class LoadAnnonceWithPartnerSponsor extends AnnonceEvent {
  final String id;

  const LoadAnnonceWithPartnerSponsor({
    required this.id,
  });
}

class LoadMoreListItem extends AnnonceEvent {
  const LoadMoreListItem();
}

class LoadMoreListRecentItem extends AnnonceEvent {
  const LoadMoreListRecentItem();
}

class SaveAnnonceToFavorite extends AnnonceEvent {
  final String annonceID;

  const SaveAnnonceToFavorite({
    required this.annonceID,
  });
}

class QuerySubmitedListAnnonceEvent extends AnnonceEvent {
  final String query;

  const QuerySubmitedListAnnonceEvent({
    required this.query,
  });
}

class QuerySubmitedListRecentAnnonceEvent extends AnnonceEvent {
  final String query;

  const QuerySubmitedListRecentAnnonceEvent({
    required this.query,
  });
}

class UpdateAnnonce extends AnnonceEvent {
  final Annonce annonce;

  const UpdateAnnonce({
    required this.annonce,
  });
}

class MakeFavAnnonceEvent extends AnnonceEvent {
  final int id;
  final bool isLiked;

  const MakeFavAnnonceEvent({
    required this.id,
    required this.isLiked,
  });
}

class ReactAnnonceEvent extends AnnonceEvent {
  final int id;
  final bool isLiked;

  const ReactAnnonceEvent({
    required this.id,
    required this.isLiked,
  });
}

class DeleteAnnonceEvent extends AnnonceEvent {
  final String annonceID;
  final AnnonceType annonceType;

  const DeleteAnnonceEvent(
      {required this.annonceID, required this.annonceType});
}

class DeleteRecentAnnonceEvent extends AnnonceEvent {
  final String annonceID;
  final AnnonceType annonceType;

  const DeleteRecentAnnonceEvent(
      {required this.annonceID, required this.annonceType});
}

class AnnonceSelectedModifiedEvent extends AnnonceEvent {
  final Annonce annonce;

  const AnnonceSelectedModifiedEvent({
    required this.annonce,
  });
}

class NewCommentaireAnnonceEvent extends AnnonceEvent {
  final int annonceID;
  final String content;

  const NewCommentaireAnnonceEvent(
      {required this.annonceID, required this.content});
}

class LikeCommentaireAnnonceEvent extends AnnonceEvent {
  final int id;
  final bool isLiked;

  const LikeCommentaireAnnonceEvent({required this.id, required this.isLiked});
}

class UpdateCommentaireAnnonceEvent extends AnnonceEvent {
  final Commentaire commentaire;
  final int index;

  const UpdateCommentaireAnnonceEvent(
      {required this.commentaire, required this.index});
}

class DeleteCommentaireAnnonceEvent extends AnnonceEvent {
  final int id;
  final int annonceID;

  const DeleteCommentaireAnnonceEvent(
      {required this.id, required this.annonceID});
}

class ToogleToEditModeCommentaireEvent extends AnnonceEvent {
  final int id;

  const ToogleToEditModeCommentaireEvent({
    required this.id,
  });
}

class LoadMoreCommentaireListItem extends AnnonceEvent {
  const LoadMoreCommentaireListItem();
}

class ExtendValidityAnnonceEvent extends AnnonceEvent {
  final int idAnnonce;
  final int idTarifOption;

  const ExtendValidityAnnonceEvent({
    required this.idAnnonce,
    required this.idTarifOption,
  });
}
