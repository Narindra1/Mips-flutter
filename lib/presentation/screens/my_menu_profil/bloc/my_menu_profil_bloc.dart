import 'package:mips/common/constants/constant.dart';
import 'package:mips/common/error/failures.dart';
import 'package:mips/domain/domain.dart';
import 'package:mips/domain/usecases/annonces/get_user_favorite_annonces_count_usecase.dart';
import 'package:mips/domain/usecases/annonces/get_user_favorite_annonces_usecase.dart';
import 'package:mips/presentation/widgets/message_displayer_utils.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'my_menu_profil_event.dart';

part 'my_menu_profil_state.dart';

class MyMenuProfilBloc extends Bloc<MyMenuProfilEvent, MyMenuProfilState> {
  final GetUserMenuProfilUseCase getUserMenuProfilUseCase;
  final GetUserFavoriteAnnoncesUsecase getUserFavoriteAnnoncesUsecase;
  final GetUserFavoriteAnnoncesCountUsecase getUserFavoriteAnnoncesCountUsecase;
  final LikeScreenUseCase likeScreenUseCase;
  final MakeFavAnnonceUseCase likeAnnonceUseCase;

  int currentPage = 1;

  MyMenuProfilBloc({
    required this.getUserMenuProfilUseCase,
    required this.getUserFavoriteAnnoncesUsecase,
    required this.getUserFavoriteAnnoncesCountUsecase,
    required this.likeScreenUseCase,
    required this.likeAnnonceUseCase,
  }) : super(MyMenuProfilState.initial()) {
    on<LoadUserMenuProfilEvent>(_onLoadUserMenuProfilEvent);
    on<LoadAnnoncesFavorisCount>(_onLoadAnnoncesFavorisCount);
    on<DeleteAnnonceFromFavsEvent>(_onDeleteAnnonceFromFavsEvent);
    on<DeleteMenuFromFavsEvent>(_onDeleteMenuFromFavsEvent);
    on<LoadAnnoncesFavoris>(_onLoadAnnoncesFavoris);
    on<LoadMoreAnnoncesFavoris>(_onLoadMoreAnnoncesFavoris);
  }

  void _onLoadAnnoncesFavorisCount(
    LoadAnnoncesFavorisCount event,
    Emitter emit,
  ) async {
    emit(
      state.copyWith(
        annoncesFavorisCountStatus: AnnoncesFavorisCountStatus.loading,
      ),
    );
    var result = await getUserFavoriteAnnoncesCountUsecase();
    if (result.isSuccess()) {
      emit(
        state.copyWith(
          annoncesFavorisCount: result.getSuccess(),
          annoncesFavorisCountStatus: AnnoncesFavorisCountStatus.loaded,
        ),
      );
    } else {
      emit(
        state.copyWith(
          annoncesFavorisCountStatus: AnnoncesFavorisCountStatus.error,
        ),
      );
    }
  }

  _onLoadUserMenuProfilEvent(
    LoadUserMenuProfilEvent event,
    Emitter emit,
  ) async {
    emit(state.copyWith(status: Status.loading));
    var result = await getUserMenuProfilUseCase();
    if (result.isSuccess()) {
      emit(
        state.copyWith(
          status: Status.loaded,
          userMenuProfil: result.getSuccess(),
        ),
      );
    } else {
      emit(state.copyWith(status: Status.error));
    }
  }

  _onDeleteAnnonceFromFavsEvent(
    DeleteAnnonceFromFavsEvent event,
    Emitter emit,
  ) async {
    var result = await likeAnnonceUseCase(event.id, false);
    if (result.isSuccess()) {
      List<Annonce> annonceFavoris = state.annoncesFavoris;
      annonceFavoris.removeWhere((element) => element.id == event.id);
      add(LoadAnnoncesFavoris(pageIndex: 1));
      MessageDisplayerUtils.showToastMessageV2(MessageType.favsRemoved);
    } else {
      MessageDisplayerUtils.showToastMessageV2(MessageType.errorOperation);
    }
  }

  _onDeleteMenuFromFavsEvent(
    DeleteMenuFromFavsEvent event,
    Emitter emit,
  ) async {
    var result = await likeScreenUseCase(event.id.toString(), false);
    if (result.isSuccess()) {
      List<MenuItem> menuFavoris = state.userMenuProfil.menuFavoris;
      menuFavoris.removeWhere((element) => element.id == event.id);
      emit(
        state.copyWith(
          userMenuProfil: state.userMenuProfil.copyWith(
            menuFavoris: menuFavoris,
          ),
        ),
      );
      MessageDisplayerUtils.showToastMessageV2(MessageType.favsRemoved);
    } else {
      MessageDisplayerUtils.showToastMessageV2(MessageType.errorOperation);
    }
  }

  _onLoadAnnoncesFavoris(LoadAnnoncesFavoris event, Emitter emit) async {
    /// Initialisation lors du premier chargement
    currentPage = event.pageIndex;

    emit(
      state.copyWith(
        annoncesFavorisStatus: AnnoncesFavorisStatus.loading,
        isNextListAvailable: true,
      ),
    );
    var results = await getUserFavoriteAnnoncesUsecase(currentPage, "");
    if (results.isSuccess()) {
      List<Annonce> annonceNormal = [];

      for (var annonce in results.getSuccess()!) {
        if (annonce.annonceType == AnnonceType.general) {
          annonceNormal.add(annonce);
        }
      }
      emit(
        state.copyWith(
          annoncesFavorisStatus: AnnoncesFavorisStatus.loaded,
          annoncesFavoris: annonceNormal,
          isNextListAvailable: annonceNormal.length >= 10,
        ),
      );
    } else {
      if (results.isError() is ItemNotFoundFailure) {
        emit(
          state.copyWith(annoncesFavorisStatus: AnnoncesFavorisStatus.error),
        );
      } else {
        emit(
          state.copyWith(annoncesFavorisStatus: AnnoncesFavorisStatus.error),
        );
      }
    }
  }

  _onLoadMoreAnnoncesFavoris(
    LoadMoreAnnoncesFavoris event,
    Emitter emit,
  ) async {
    // emit(state.copyWith(listStatus: ListStatus.loading));
    if (!state.isNextListAvailable) {
      return null;
    }
    currentPage = currentPage + 1;
    var results = await getUserFavoriteAnnoncesUsecase(currentPage, "");
    if (results.isSuccess()) {
      /// Filtrer le type d'annonce
      List<Annonce> annonceNormal = [];
      for (var annonce in results.getSuccess()!) {
        annonceNormal.add(annonce);
      }
      if (annonceNormal.isEmpty) {
        emit(
          state.copyWith(
            annoncesFavorisStatus: AnnoncesFavorisStatus.loaded,
            isNextListAvailable: false,
          ),
        );
      } else {
        emit(
          state.copyWith(
            annoncesFavorisStatus: AnnoncesFavorisStatus.loaded,
            annoncesFavoris: state.annoncesFavoris + annonceNormal,
            isNextListAvailable: annonceNormal.length >= 10,
          ),
        );
      }
    } else {
      if (results.isError() is ItemNotFoundFailure) {
        emit(
          state.copyWith(annoncesFavorisStatus: AnnoncesFavorisStatus.error),
        );
      } else {
        emit(
          state.copyWith(annoncesFavorisStatus: AnnoncesFavorisStatus.error),
        );
      }
    }
  }
}
