// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'annonce_bloc.dart';

enum GetBonusStatus { getting, got, error }

enum ListStatus { loading, loaded, error }

enum SelectedStatus { loading, loaded, error, deleted }

enum CommentaireStatus { posting, loaded, error }

enum CommentaireListStatus { loaded, loading, error }

class AnnonceState {
  final List<Annonce> annoncesPartenaire;
  final List<Annonce> annoncesSponsor;
  final List<Annonce> annoncesPremium;
  final List<Annonce> annoncesNormal;
  final List<Annonce> annoncesVIP;
  final Annonce? selectedAnnonce;
  final ListStatus listStatus;
  final bool annonceBonusHasGot;
  final bool isNextListAvailable;
  final bool isNextCommentaireListAvailable;
  final GetBonusStatus getBonusStatus;
  final SelectedStatus selectedStatus;
  final CommentaireStatus commentaireStatus;
  final CommentaireListStatus commentaireListStatus;
  final String query;

  final int idCommentaireInProcess;

  const AnnonceState(
      {required this.listStatus,
      required this.annoncesVIP,
      required this.selectedStatus,
      required this.getBonusStatus,
      required this.annonceBonusHasGot,
      required this.annoncesNormal,
      required this.annoncesPartenaire,
      required this.annoncesPremium,
      required this.annoncesSponsor,
      required this.commentaireStatus,
      required this.commentaireListStatus,
      this.selectedAnnonce,
      required this.isNextCommentaireListAvailable,
      required this.isNextListAvailable,
      required this.idCommentaireInProcess,
      required this.query});

  factory AnnonceState.initial() {
    return const AnnonceState(
        annoncesNormal: [],
        annoncesSponsor: [],
        annoncesPremium: [],
        annoncesPartenaire: [],
        annoncesVIP: [],
        listStatus: ListStatus.loading,
        selectedStatus: SelectedStatus.loading,
        getBonusStatus: GetBonusStatus.getting,
        commentaireListStatus: CommentaireListStatus.loaded,
        commentaireStatus: CommentaireStatus.loaded,
        annonceBonusHasGot: false,
        isNextListAvailable: true,
        isNextCommentaireListAvailable: true,
        idCommentaireInProcess: -1,
        query: "",
        selectedAnnonce: null);
  }

  AnnonceState copyWith(
      {List<Annonce>? annoncesPartenaire,
      List<Annonce>? annoncesSponsor,
      List<Annonce>? annoncesPremium,
      List<Annonce>? annoncesNormal,
      List<Annonce>? annoncesVIP,
      Annonce? selectedAnnonce,
      ListStatus? listStatus,
      bool? annonceBonusHasGot,
      bool? isNextListAvailable,
      bool? isNextCommentaireListAvailable,
      SelectedStatus? selectedStatus,
      GetBonusStatus? getBonusStatus,
      CommentaireStatus? commentaireStatus,
      CommentaireListStatus? commentaireListStatus,
      String? query,
      int? idCommentaireInProcess,
      bool reInitializeSelectedAnnonce = false}) {
    return AnnonceState(
      annoncesVIP: annoncesVIP ?? this.annoncesVIP,
      idCommentaireInProcess:
          idCommentaireInProcess ?? this.idCommentaireInProcess,
      annoncesPartenaire: annoncesPartenaire ?? this.annoncesPartenaire,
      annoncesSponsor: annoncesSponsor ?? this.annoncesSponsor,
      annoncesPremium: annoncesPremium ?? this.annoncesPremium,
      annoncesNormal: annoncesNormal ?? this.annoncesNormal,
      annonceBonusHasGot: annonceBonusHasGot ?? this.annonceBonusHasGot,
      selectedAnnonce: reInitializeSelectedAnnonce
          ? null
          : (selectedAnnonce ?? this.selectedAnnonce),
      listStatus: listStatus ?? this.listStatus,
      isNextListAvailable: isNextListAvailable ?? this.isNextListAvailable,
      isNextCommentaireListAvailable:
          isNextCommentaireListAvailable ?? this.isNextCommentaireListAvailable,
      selectedStatus: selectedStatus ?? this.selectedStatus,
      getBonusStatus: getBonusStatus ?? this.getBonusStatus,
      commentaireStatus: commentaireStatus ?? this.commentaireStatus,
      commentaireListStatus:
          commentaireListStatus ?? this.commentaireListStatus,
      query: query ?? this.query,
    );
  }
}
