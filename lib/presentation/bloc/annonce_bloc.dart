import 'package:MIPS/common/common.dart';
import 'package:MIPS/domain/usecases/annonces/create_annonce_plainte_suggestion_usecase.dart';
import 'package:MIPS/domain/usecases/annonces/get_annonce_with_partner_sponsor_usecase.dart';
import 'package:MIPS/domain/usecases/annonces/get_bonus_from_annonce_usecase.dart';
import 'package:MIPS/domain/usecases/annonces/get_recents_annonces_usecase.dart';
import 'package:bloc/bloc.dart';

import '../../domain/domain.dart';

part 'annonce_event.dart';

part 'annonce_state.dart';

class AnnonceBloc extends Bloc<AnnonceEvent, AnnonceState> {
  final GetAllAnnoncesByIdScreenUseCase getAllAnnoncesByIdScreenUseCase;
  final GetRecentsAnnoncesUsecase getRecentsAnnoncesUsecase;
  final GetAnnonceUseCase getAnnonceUseCase;
  final GetAnnonceWithPartnerSponsorUsecase getAnnonceWithPartnerSponsorUsecase;
  final GetBonusFromAnnonceUsecase getBonusFromAnnonceUsecase;
  final CreateAnnonceUseCase createAnnonceUseCase;
  final CreateAnnoncePlainteSuggestionUsecase
      createAnnoncePlainteSuggestionUsecase;
  final DeleteAnnonceUseCase deleteAnnonceUseCase;
  final MakeFavAnnonceUseCase makeFavAnnonceUseCase;
  final ReactToAnnonceUseCase reactToAnnonceUseCase;
  final UpdateAnnonceUseCase updateAnnonceUseCase;
  final GetCommentaireByAnnonceUseCase getAllCommentaireByAnnonceUseCase;
  final CreateCommentaireUseCase createCommentaireUseCase;
  final UpdateCommentaireUseCase updateCommentaireUseCase;
  final DeleteCommentaireUseCase deleteCommentaireUseCase;
  final ExtendValidityAnnonceUsecase extendValidityAnnonceUsecase;

  int annonceListID = 0;
  int currentPage = 1;
  int currentCommentairePage = 1;

  AnnonceBloc({
    required this.getAllAnnoncesByIdScreenUseCase,
    required this.getAnnonceUseCase,
    required this.getBonusFromAnnonceUsecase,
    required this.getRecentsAnnoncesUsecase,
    required this.getAnnonceWithPartnerSponsorUsecase,
    required this.createAnnonceUseCase,
    required this.createAnnoncePlainteSuggestionUsecase,
    required this.deleteAnnonceUseCase,
    required this.reactToAnnonceUseCase,
    required this.makeFavAnnonceUseCase,
    required this.updateAnnonceUseCase,
    required this.createCommentaireUseCase,
    required this.getAllCommentaireByAnnonceUseCase,
    required this.updateCommentaireUseCase,
    required this.extendValidityAnnonceUsecase,
    required this.deleteCommentaireUseCase,
  }) : super(AnnonceState.initial()) {
    on<LoadAnnonceList>(_onLoadAnnonceList);
    on<LoadRecentAnnonceList>(_onLoadRecentAnnonceList);
    on<LoadAnnonce>(_onLoadAnnonce);
    on<GetBonusFromAnnonceEvent>(_onGetBonusFromAnnonceEvent);
    on<LoadAnnonceWithPartnerSponsor>(_onLoadAnnonceWithPartnerSponsor);
    on<LoadMoreListItem>(_onLoadMoreListItem);
    on<LoadMoreListRecentItem>(_onLoadMoreListRecentItem);
    on<QuerySubmitedListAnnonceEvent>(_onQuerySubmitedListAnnonceEvent);
    on<QuerySubmitedListRecentAnnonceEvent>(
        _onQuerySubmitedListRecentAnnonceEvent);
    on<MakeFavAnnonceEvent>(_onMakeFavAnnonceEvent);
    on<ReactAnnonceEvent>(_onReactAnnonceEvent);
    on<UpdateAnnonce>(_onUpdateAnnonceEvent);
    on<NewCommentaireAnnonceEvent>(_onNewCommentaireAnnonceEvent);
    on<LoadMoreCommentaireListItem>(_onLoadMoreCommentaireListItem);
    on<UpdateCommentaireAnnonceEvent>(_onUpdateCommentaireAnnonceEvent);
    on<AnnonceSelectedModifiedEvent>(_onAnnonceSelectedModifiedEvent);
    on<DeleteAnnonceEvent>(_onDeleteAnnonceEvent);
    on<DeleteRecentAnnonceEvent>(_onDeleteRecentAnnonceEvent);
    on<DeleteCommentaireAnnonceEvent>(_onDeleteCommentaireAnnonceEvent);
    on<ExtendValidityAnnonceEvent>(_onExtendValidityAnnonceEvent);
  }

  _onDeleteCommentaireAnnonceEvent(
      DeleteCommentaireAnnonceEvent event, Emitter emit) async {
    emit(state.copyWith(idCommentaireInProcess: event.id));
    var result = await deleteCommentaireUseCase(event.id, event.annonceID);
    if (result.isSuccess()) {
      /// Devrait mettre à jour la liste après la suppression
      Annonce annonce = state.selectedAnnonce!;
      annonce.commentaires.removeWhere((element) => element.id == event.id);
      emit(
          state.copyWith(idCommentaireInProcess: -1, selectedAnnonce: annonce));
    }
  }

  _onExtendValidityAnnonceEvent(
      ExtendValidityAnnonceEvent event, Emitter emit) async {
    emit(state.copyWith());
    var result = await extendValidityAnnonceUsecase(
        event.idAnnonce, event.idTarifOption);
    if (result.isSuccess()) {}
  }

  _onDeleteAnnonceEvent(DeleteAnnonceEvent event, Emitter emit) async {
    emit(state.copyWith(selectedStatus: SelectedStatus.loading));
    var result = await deleteAnnonceUseCase(event.annonceID);
    if (result.isSuccess()) {
      emit(state.copyWith(
        selectedStatus: SelectedStatus.deleted,
      ));
      add(LoadAnnonceList(id: annonceListID, pageIndex: 1));
    } else {
      emit(state.copyWith(selectedStatus: SelectedStatus.error));
    }
  }

  _onDeleteRecentAnnonceEvent(
      DeleteRecentAnnonceEvent event, Emitter emit) async {
    emit(state.copyWith(selectedStatus: SelectedStatus.loading));
    var result = await deleteAnnonceUseCase(event.annonceID);
    if (result.isSuccess()) {
      emit(state.copyWith(
        selectedStatus: SelectedStatus.deleted,
      ));
      add(LoadRecentAnnonceList(id: annonceListID, pageIndex: 1));
    } else {
      emit(state.copyWith(selectedStatus: SelectedStatus.error));
    }
  }

  _onGetBonusFromAnnonceEvent(
      GetBonusFromAnnonceEvent event, Emitter emit) async {
    emit(state.copyWith(getBonusStatus: GetBonusStatus.getting));
    var result = await getBonusFromAnnonceUsecase(event.idAnnonce);
    if (result.isSuccess()) {
      emit(state.copyWith(getBonusStatus: GetBonusStatus.got));
    } else {
      emit(state.copyWith(getBonusStatus: GetBonusStatus.error));
    }
  }

  _onAnnonceSelectedModifiedEvent(
      AnnonceSelectedModifiedEvent event, Emitter emit) {
    /// Vérifie le type d'annonce afin de mettre à jour
    List<Annonce> annonceList = [];
    switch (event.annonce.annonceType) {
      case AnnonceType.premium:
        annonceList = state.annoncesPremium;

        int annonceIndex =
            annonceList.indexWhere((element) => element.id == event.annonce.id);
        if (annonceIndex >= 0) {
          annonceList[annonceIndex] = event.annonce;
        } else {
          try {
            annonceList.add(event.annonce);
          } catch (_) {
            annonceList = [];
            annonceList.add(event.annonce);
          }
        }
        emit(state.copyWith(
            annoncesPremium: annonceList, selectedAnnonce: event.annonce));
        break;
      case AnnonceType.sponsor:
        annonceList = state.annoncesSponsor;
        annonceList = [event.annonce];
        emit(state.copyWith(
            annoncesSponsor: annonceList, selectedAnnonce: event.annonce));
        break;
      case AnnonceType.vip:
        annonceList = state.annoncesVIP;
        int annonceIndex =
            annonceList.indexWhere((element) => element.id == event.annonce.id);
        if (annonceIndex >= 0) {
          annonceList[annonceIndex] = event.annonce;
        } else {
          try {
            annonceList.add(event.annonce);
          } catch (_) {
            annonceList = [];
            annonceList.add(event.annonce);
          }
        }
        emit(state.copyWith(
            annoncesVIP: annonceList, selectedAnnonce: event.annonce));
        break;
      case AnnonceType.partenaire:
        annonceList = state.annoncesPartenaire;
        annonceList = [event.annonce];
        emit(state.copyWith(
            annoncesPartenaire: annonceList, selectedAnnonce: event.annonce));
        break;
      // case AnnonceType.general:
      default:
        annonceList = state.annoncesNormal;
        int annonceIndex =
            annonceList.indexWhere((element) => element.id == event.annonce.id);
        if (annonceList.isNotEmpty && annonceIndex < annonceList.length) {
          annonceList[annonceIndex] = event.annonce;
        }
        emit(state.copyWith(
            annoncesNormal: annonceList, selectedAnnonce: event.annonce));
    }
  }

  _onUpdateCommentaireAnnonceEvent(
      UpdateCommentaireAnnonceEvent event, Emitter emit) async {
    var result = await updateCommentaireUseCase(event.commentaire);
    if (result.isSuccess()) {
      /// Nécessite de mettre à jour le bon commentaire
      state.selectedAnnonce!.commentaires[event.index] = result.getSuccess()!;

      /// On force une reconstruction en créant une nouvelle instance d’état
      emit(state.copyWith());
    }
  }

  _onLoadMoreCommentaireListItem(
      LoadMoreCommentaireListItem event, Emitter emit) async {
    emit(state.copyWith(commentaireListStatus: CommentaireListStatus.loading));
    if (!state.isNextCommentaireListAvailable) {
      return null;
    }
    currentCommentairePage = currentCommentairePage + 1;
    var results = await getAllCommentaireByAnnonceUseCase(
        state.selectedAnnonce!.id.toString(), currentCommentairePage);
    if (results.isSuccess()) {
      /// Filtrer le type d'annonce
      List<Commentaire> commentaireList = [];
      for (var commentaire in results.getSuccess()!) {
        /// Les annonces provenant de la pagination sont uniquement de type NORMAL
        commentaireList.add(commentaire);
      }
      if (commentaireList.isEmpty) {
        emit(state.copyWith(
            commentaireListStatus: CommentaireListStatus.loaded,
            isNextCommentaireListAvailable: false));
      } else {
        state.selectedAnnonce!.commentaires.addAll(commentaireList);

        emit(state.copyWith(
            commentaireListStatus: CommentaireListStatus.loaded,
            selectedAnnonce: state.selectedAnnonce,
            isNextCommentaireListAvailable: commentaireList.length >= 10));
      }
    } else {
      if (results.isError() is ItemNotFoundFailure) {
        emit(state.copyWith(listStatus: ListStatus.error));
      } else {
        emit(state.copyWith(listStatus: ListStatus.error));
      }
    }
  }

  _onNewCommentaireAnnonceEvent(
      NewCommentaireAnnonceEvent event, Emitter emit) async {
    emit(state.copyWith(commentaireStatus: CommentaireStatus.posting));

    var result = await createCommentaireUseCase(event.annonceID, event.content);
    if (result.isSuccess()) {
      if (result.getSuccess() != null) {
        state.selectedAnnonce?.commentaires.insert(0, result.getSuccess()!);
        emit(state.copyWith(
            commentaireStatus: CommentaireStatus.loaded,
            selectedAnnonce: state.selectedAnnonce));
      }
    } else {
      emit(state.copyWith(commentaireStatus: CommentaireStatus.error));
    }
  }

  _onUpdateAnnonceEvent(UpdateAnnonce event, Emitter emit) async {}

  _onMakeFavAnnonceEvent(MakeFavAnnonceEvent event, Emitter emit) async {
    if (state.selectedAnnonce != null) {
      Annonce annonce = state.selectedAnnonce!.copyWith(isFavs: event.isLiked);
      emit(state.copyWith(selectedAnnonce: annonce));
      var result = await makeFavAnnonceUseCase(event.id, event.isLiked);
      if (result.isSuccess()) {
        Annonce annonce = state.selectedAnnonce!
            .copyWith(isFavs: result.getSuccess()!.isFavs);
        emit(state.copyWith(selectedAnnonce: annonce));
      }
    }
  }

  _onReactAnnonceEvent(ReactAnnonceEvent event, Emitter emit) async {
    if (state.selectedAnnonce != null) {
      Annonce annonce = state.selectedAnnonce!.copyWith(isLiked: event.isLiked);
      emit(state.copyWith(selectedAnnonce: annonce));
      var result = await reactToAnnonceUseCase(event.id, event.isLiked);
      if (result.isSuccess()) {
        Annonce annonce = state.selectedAnnonce!.copyWith(
            isLiked: result.getSuccess()!.isLiked,
            reactionCount: result.getSuccess()!.reactionCount);
        emit(state.copyWith(selectedAnnonce: annonce));
      }
    }
  }

  _onQuerySubmitedListAnnonceEvent(
      QuerySubmitedListAnnonceEvent event, Emitter emit) async {
    currentPage = 1;
    emit(state.copyWith(
        listStatus: ListStatus.loading,
        isNextListAvailable: true,
        query: event.query));
    var results = await getAllAnnoncesByIdScreenUseCase(
        annonceListID, currentPage, event.query);
    if (results.isSuccess()) {
      // Filtrer le type d'annonce
      List<Annonce> annonceNormal = [];
      for (var annonce in results.getSuccess()!) {
        // Les annonces provenant de la pagination sont uniquement de type NORMAL
        switch (annonce.annonceType) {
          case AnnonceType.general:
          default:
            annonceNormal.add(annonce);
        }
      }
      if (annonceNormal.isEmpty) {
        emit(state.copyWith(
            annoncesNormal: annonceNormal,
            listStatus: ListStatus.loaded,
            isNextListAvailable: false));
      } else {
        emit(state.copyWith(
            listStatus: ListStatus.loaded,
            annoncesNormal: annonceNormal,
            isNextListAvailable: annonceNormal.length >= 10));
      }
    } else {
      if (results.isError() is ItemNotFoundFailure) {
        emit(state.copyWith(listStatus: ListStatus.error));
      } else {
        emit(state.copyWith(listStatus: ListStatus.error));
      }
    }
  }

  _onQuerySubmitedListRecentAnnonceEvent(
      QuerySubmitedListRecentAnnonceEvent event, Emitter emit) async {
    currentPage = 1;
    emit(state.copyWith(
        listStatus: ListStatus.loading,
        isNextListAvailable: true,
        query: event.query));
    var results = await getRecentsAnnoncesUsecase(
        annonceListID, currentPage, event.query);
    if (results.isSuccess()) {
      // Filtrer le type d'annonce
      List<Annonce> annonceNormal = [];
      for (var annonce in results.getSuccess()!) {
        annonceNormal.add(annonce);
      }
      if (annonceNormal.isEmpty) {
        emit(state.copyWith(
            annoncesNormal: annonceNormal,
            listStatus: ListStatus.loaded,
            isNextListAvailable: false));
      } else {
        emit(state.copyWith(
            listStatus: ListStatus.loaded,
            annoncesNormal: annonceNormal,
            isNextListAvailable: annonceNormal.length >= 10));
      }
    } else {
      if (results.isError() is ItemNotFoundFailure) {
        emit(state.copyWith(listStatus: ListStatus.error));
      } else {
        emit(state.copyWith(listStatus: ListStatus.error));
      }
    }
  }

  _onLoadMoreListItem(LoadMoreListItem event, Emitter emit) async {
    // emit(state.copyWith(listStatus: ListStatus.loading));
    if (!state.isNextListAvailable) {
      return null;
    }
    currentPage = currentPage + 1;
    var results = await getAllAnnoncesByIdScreenUseCase(
        annonceListID, currentPage, state.query);
    if (results.isSuccess()) {
      /// Filtrer le type d'annonce
      List<Annonce> annonceNormal = [];
      for (var annonce in results.getSuccess()!) {
        /// Les annonces provenant de la pagination sont uniquement de type NORMAL
        switch (annonce.annonceType) {
          case AnnonceType.general:
          default:
            annonceNormal.add(annonce);
        }
      }
      if (annonceNormal.isEmpty) {
        emit(state.copyWith(
            listStatus: ListStatus.loaded, isNextListAvailable: false));
      } else {
        emit(state.copyWith(
            listStatus: ListStatus.loaded,
            annoncesNormal: state.annoncesNormal + annonceNormal,
            isNextListAvailable: annonceNormal.length >= 10));
      }
    } else {
      if (results.isError() is ItemNotFoundFailure) {
        emit(state.copyWith(listStatus: ListStatus.error));
      } else {
        emit(state.copyWith(listStatus: ListStatus.error));
      }
    }
  }

  _onLoadMoreListRecentItem(LoadMoreListRecentItem event, Emitter emit) async {
    // emit(state.copyWith(listStatus: ListStatus.loading));
    if (!state.isNextListAvailable) {
      return null;
    }
    currentPage = currentPage + 1;
    var results = await getRecentsAnnoncesUsecase(
        annonceListID, currentPage, state.query);
    if (results.isSuccess()) {
      /// Filtrer le type d'annonce
      List<Annonce> annonceNormal = [];
      for (var annonce in results.getSuccess()!) {
        annonceNormal.add(annonce);
      }
      if (annonceNormal.isEmpty) {
        emit(state.copyWith(
            listStatus: ListStatus.loaded, isNextListAvailable: false));
      } else {
        emit(state.copyWith(
            listStatus: ListStatus.loaded,
            annoncesNormal: state.annoncesNormal + annonceNormal,
            isNextListAvailable: annonceNormal.length >= 10));
      }
    } else {
      if (results.isError() is ItemNotFoundFailure) {
        emit(state.copyWith(listStatus: ListStatus.error));
      } else {
        emit(state.copyWith(listStatus: ListStatus.error));
      }
    }
  }

  _onLoadAnnonceList(LoadAnnonceList event, Emitter emit) async {
    /// Initialisation lors du premier chargement
    annonceListID = event.id;
    currentPage = 1;

    emit(state.copyWith(
        listStatus: ListStatus.loading, isNextListAvailable: true, query: ""));
    var results =
        await getAllAnnoncesByIdScreenUseCase(annonceListID, currentPage, "");
    if (results.isSuccess()) {
      // Filtrer par type d'annonce
      List<Annonce> annoncePremium = [];
      List<Annonce> annonceSponsor = [];
      List<Annonce> annoncePartenaire = [];
      List<Annonce> annonceNormal = [];
      List<Annonce> annonceVIP = [];

      for (var annonce in results.getSuccess()!) {
        switch (annonce.annonceType) {
          case AnnonceType.sponsor:
            annonceSponsor.add(annonce);
            break;
          case AnnonceType.partenaire:
            annoncePartenaire.add(annonce);
            break;
          case AnnonceType.premium:
            annoncePremium.add(annonce);
            break;
          case AnnonceType.vip:
            annonceVIP.add(annonce);
            break;
          // case AnnonceType.general:
          default:
            annonceNormal.add(annonce);
        }
      }
      emit(state.copyWith(
          listStatus: ListStatus.loaded,
          annoncesPremium: annoncePremium,
          annoncesSponsor: annonceSponsor,
          annoncesNormal: annonceNormal,
          annoncesVIP: annonceVIP,
          isNextListAvailable: annonceNormal.length >= 10,
          annoncesPartenaire: annoncePartenaire));
    } else {
      if (results.isError() is ItemNotFoundFailure) {
        emit(state.copyWith(listStatus: ListStatus.error));
      } else {
        emit(state.copyWith(listStatus: ListStatus.error));
      }
    }
  }

  _onLoadRecentAnnonceList(LoadRecentAnnonceList event, Emitter emit) async {
    /// Initialisation lors du premier chargement
    annonceListID = event.id;
    currentPage = 1;

    emit(state.copyWith(
        listStatus: ListStatus.loading, isNextListAvailable: true, query: ""));
    var results =
        await getRecentsAnnoncesUsecase(annonceListID, currentPage, "");
    if (results.isSuccess()) {
      // Filtrer par type d'annonce
      List<Annonce> annonceNormal = [];

      for (var annonce in results.getSuccess()!) {
        annonceNormal.add(annonce);
      }
      emit(state.copyWith(
        listStatus: ListStatus.loaded,
        annoncesNormal: annonceNormal,
        isNextListAvailable: annonceNormal.length >= 10,
      ));
    } else {
      if (results.isError() is ItemNotFoundFailure) {
        emit(state.copyWith(listStatus: ListStatus.error));
      } else {
        emit(state.copyWith(listStatus: ListStatus.error));
      }
    }
  }

  _onLoadAnnonce(LoadAnnonce event, Emitter emit) async {
    currentCommentairePage = 1;
    emit(state.copyWith(
        idCommentaireInProcess: -1,
        reInitializeSelectedAnnonce: true,
        selectedStatus: SelectedStatus.loading,
        commentaireStatus: CommentaireStatus.loaded,
        commentaireListStatus: CommentaireListStatus.loaded));
    var results = await getAnnonceUseCase(event.id);
    if (results.isSuccess()) {
      emit(state.copyWith(
          selectedStatus: SelectedStatus.loaded,
          selectedAnnonce: results.getSuccess(),
          isNextCommentaireListAvailable:
              results.getSuccess()!.commentaires.length >= 10));
    } else {
      if (results.isError() is ItemNotFoundFailure) {
        emit(state.copyWith(selectedStatus: SelectedStatus.error));
      } else {
        emit(state.copyWith(selectedStatus: SelectedStatus.error));
      }
    }
  }

  _onLoadAnnonceWithPartnerSponsor(
      LoadAnnonceWithPartnerSponsor event, Emitter emit) async {
    /// Initialisation lors du premier chargement
    currentCommentairePage = 1;
    emit(state.copyWith(
        idCommentaireInProcess: -1,
        reInitializeSelectedAnnonce: true,
        selectedStatus: SelectedStatus.loading,
        commentaireStatus: CommentaireStatus.loaded,
        commentaireListStatus: CommentaireListStatus.loaded));
    var results = await getAnnonceWithPartnerSponsorUsecase(event.id);
    if (results.isSuccess()) {
      // Filtrer par type d'annonce
      List<Annonce> annonceSponsor = [];
      List<Annonce> annoncePartenaire = [];
      List<Annonce> annonceNormal = [];

      for (var annonce in results.getSuccess()!) {
        switch (annonce.annonceType) {
          case AnnonceType.sponsor:
            annonceSponsor.add(annonce);
            break;
          case AnnonceType.partenaire:
            annoncePartenaire.add(annonce);
            break;
          case AnnonceType.general:
          default:
            annonceNormal.add(annonce);
        }
      }
      emit(state.copyWith(
          selectedStatus: SelectedStatus.loaded,
          annoncesPartenaire: annoncePartenaire,
          annoncesSponsor: annonceSponsor,
          selectedAnnonce: annonceNormal[0],
          isNextCommentaireListAvailable:
              annonceNormal[0].commentaires.length >= 10));
    } else {
      if (results.isError() is ItemNotFoundFailure) {
        emit(state.copyWith(selectedStatus: SelectedStatus.error));
      } else {
        emit(state.copyWith(selectedStatus: SelectedStatus.error));
      }
    }
  }
}
