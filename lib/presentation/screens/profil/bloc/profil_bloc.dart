import 'package:mips/common/constants/constant.dart';
import 'package:mips/common/error/failures.dart';
import 'package:mips/domain/domain.dart';
import 'package:mips/domain/entities/profil.dart';
import 'package:mips/domain/usecases/profil/get_annonces_user_profil_count_usecase.dart';
import 'package:mips/domain/usecases/profil/get_annonces_user_profil_usecase.dart';
import 'package:mips/domain/usecases/profil/get_user_info_profil_by_id_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'profil_event.dart';
part 'profil_state.dart';

class ProfilBloc extends Bloc<ProfilEvent, ProfilState> {
  ProfilBloc({
    required this.getUserInfoProfilByIdUsecase,
    required this.getAnnoncesUserProfilCountUsecase,
    required this.getAnnoncesUserProfilUsecase,
  }) : super(ProfilState.initial()) {
    on<UserProfilLoaded>(_onUserProfilLoaded);
    on<AnnonceListUserProfilLoaded>(_onAnnonceListUserProfilLoaded);
    on<LoadMoreAnnonceUserProfil>(_onLoadMoreAnnonceUserProfil);
    on<AnnonceListUserProfilCountLoaded>(_onAnnonceListUserProfilCountLoaded);
  }
  final GetUserInfoProfilByIdUsecase getUserInfoProfilByIdUsecase;
  final GetAnnoncesUserProfilCountUsecase getAnnoncesUserProfilCountUsecase;
  final GetAnnoncesUserProfilUsecase getAnnoncesUserProfilUsecase;

  int currentPage = 1;

  void _onUserProfilLoaded(UserProfilLoaded event, Emitter emit) async {
    emit(state.copyWith(profilUserStatus: ProfilUserStatus.loading));
    var result = await getUserInfoProfilByIdUsecase(event.id);
    if (result.isSuccess()) {
      emit(
        state.copyWith(
          user: result.getSuccess(),
          profilUserStatus: ProfilUserStatus.loaded,
        ),
      );
    } else {
      emit(
        state.copyWith(
          error: result.getError()?.message,
          profilUserStatus: ProfilUserStatus.error,
        ),
      );
    }
  }

  void _onAnnonceListUserProfilLoaded(
    AnnonceListUserProfilLoaded event,
    Emitter emit,
  ) async {
    /// Initialisation lors du premier chargement
    currentPage = event.pageIndex;

    emit(
      state.copyWith(
        profilUserAnnoncesStatus: ProfilUserAnnoncesStatus.loading,
        isNextListAvailable: true,
      ),
    );
    var results = await getAnnoncesUserProfilUsecase(event.id, currentPage, "");
    if (results.isSuccess()) {
      List<Annonce> annonceNormal = [];

      for (var annonce in results.getSuccess()!) {
        if (annonce.annonceType == AnnonceType.general) {
          annonceNormal.add(annonce);
        }
      }
      emit(
        state.copyWith(
          profilUserAnnoncesStatus: ProfilUserAnnoncesStatus.loaded,
          annonces: annonceNormal,
          isNextListAvailable: annonceNormal.length >= 10,
        ),
      );
    } else {
      if (results.isError() is ItemNotFoundFailure) {
        emit(
          state.copyWith(
            profilUserAnnoncesStatus: ProfilUserAnnoncesStatus.error,
          ),
        );
      } else {
        emit(
          state.copyWith(
            profilUserAnnoncesStatus: ProfilUserAnnoncesStatus.error,
          ),
        );
      }
    }
  }

  void _onAnnonceListUserProfilCountLoaded(
    AnnonceListUserProfilCountLoaded event,
    Emitter emit,
  ) async {
    emit(
      state.copyWith(
        profilUserAnnoncesCountStatus: ProfilUserAnnoncesCountStatus.loading,
      ),
    );
    var result = await getAnnoncesUserProfilCountUsecase(event.id);
    if (result.isSuccess()) {
      emit(
        state.copyWith(
          annoncesCount: result.getSuccess(),
          profilUserAnnoncesCountStatus: ProfilUserAnnoncesCountStatus.loaded,
        ),
      );
    } else {
      emit(
        state.copyWith(
          error: result.getError()?.message,
          profilUserAnnoncesCountStatus: ProfilUserAnnoncesCountStatus.error,
        ),
      );
    }
  }

  _onLoadMoreAnnonceUserProfil(
    LoadMoreAnnonceUserProfil event,
    Emitter emit,
  ) async {
    // emit(state.copyWith(listStatus: ListStatus.loading));
    if (!state.isNextListAvailable) {
      return null;
    }
    currentPage = currentPage + 1;
    var results = await getAnnoncesUserProfilUsecase(event.id, currentPage, "");
    if (results.isSuccess()) {
      List<Annonce> annonceNormal = [];
      for (var annonce in results.getSuccess()!) {
        annonceNormal.add(annonce);
      }
      print("ANNONCE NORMAL : ${annonceNormal.length}");
      if (annonceNormal.isEmpty) {
        emit(
          state.copyWith(
            profilUserAnnoncesStatus: ProfilUserAnnoncesStatus.loaded,
            isNextListAvailable: false,
          ),
        );
      } else {
        emit(
          state.copyWith(
            profilUserAnnoncesStatus: ProfilUserAnnoncesStatus.loaded,
            annonces: state.annonces + annonceNormal,
            isNextListAvailable: annonceNormal.length >= 10,
          ),
        );
      }
    } else {
      if (results.isError() is ItemNotFoundFailure) {
        emit(
          state.copyWith(
            profilUserAnnoncesStatus: ProfilUserAnnoncesStatus.error,
          ),
        );
      } else {
        emit(
          state.copyWith(
            profilUserAnnoncesStatus: ProfilUserAnnoncesStatus.error,
          ),
        );
      }
    }
  }
}
