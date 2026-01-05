import 'package:MIPS/common/constants/constant.dart';
import 'package:MIPS/common/error/failures.dart';
import 'package:MIPS/domain/usecases/annonces/get_user_annonces_count_usecase.dart';
import 'package:bloc/bloc.dart';

import '../../../../domain/entities/annonce.dart';
import '../../../../domain/usecases/annonces/get_user_annonces_usecase.dart';

part 'mes_annonces_screen_event.dart';

part 'mes_annonces_screen_state.dart';

class MesAnnoncesScreenBloc
    extends Bloc<MesAnnoncesScreenEvent, MesAnnoncesScreenState> {
  final GetUserAnnoncesUseCase getUserAnnoncesUseCase;
  final GetUserAnnoncesCountUsecase getUserAnnoncesCountUsecase;

  int currentPage = 1;

  MesAnnoncesScreenBloc({
    required this.getUserAnnoncesUseCase,
    required this.getUserAnnoncesCountUsecase,
  }) : super(MesAnnoncesScreenState.initial()) {
    on<LoadMesAnnoncesCount>(_onLoadMesAnnoncesCount);
    on<LoadMesAnnonces>(_onLoadMesAnnonces);
    on<LoadMoreMesAnnonces>(_onLoadMoreMesAnnonces);
  }

  void _onLoadMesAnnoncesCount(LoadMesAnnoncesCount event, Emitter emit) async {
    emit(
        state.copyWith(mesAnnoncesCountStatus: MesAnnoncesCountStatus.loading));
    var result = await getUserAnnoncesCountUsecase();
    if (result.isSuccess()) {
      emit(state.copyWith(
          mesAnnoncesCount: result.getSuccess(),
          mesAnnoncesCountStatus: MesAnnoncesCountStatus.loaded));
    } else {
      emit(
          state.copyWith(mesAnnoncesCountStatus: MesAnnoncesCountStatus.error));
    }
  }

  _onLoadMesAnnonces(LoadMesAnnonces event, Emitter emit) async {
    /// Initialisation lors du premier chargement
    currentPage = event.pageIndex;

    emit(state.copyWith(
        mesAnnoncesStatus: MesAnnoncesStatus.loading,
        isNextListAvailable: true));
    var results = await getUserAnnoncesUseCase(currentPage, "");
    if (results.isSuccess()) {
      List<Annonce> annonceNormal = [];

      for (var annonce in results.getSuccess()!) {
        if (annonce.annonceType == AnnonceType.general) {
          annonceNormal.add(annonce);
        }
      }
      emit(state.copyWith(
        mesAnnoncesStatus: MesAnnoncesStatus.loaded,
        mesAnnonces: annonceNormal,
        isNextListAvailable: annonceNormal.length >= 10,
      ));
    } else {
      if (results.isError() is ItemNotFoundFailure) {
        emit(state.copyWith(mesAnnoncesStatus: MesAnnoncesStatus.error));
      } else {
        emit(state.copyWith(mesAnnoncesStatus: MesAnnoncesStatus.error));
      }
    }
  }

  _onLoadMoreMesAnnonces(LoadMoreMesAnnonces event, Emitter emit) async {
    // emit(state.copyWith(listStatus: ListStatus.loading));
    if (!state.isNextListAvailable) {
      return null;
    }
    currentPage = currentPage + 1;
    var results = await getUserAnnoncesUseCase(currentPage, "");
    if (results.isSuccess()) {
      /// Filtrer le type d'annonce
      List<Annonce> annonceNormal = [];
      for (var annonce in results.getSuccess()!) {
        annonceNormal.add(annonce);
      }
      if (annonceNormal.isEmpty) {
        emit(state.copyWith(
            mesAnnoncesStatus: MesAnnoncesStatus.loaded,
            isNextListAvailable: false));
      } else {
        emit(state.copyWith(
            mesAnnoncesStatus: MesAnnoncesStatus.loaded,
            mesAnnonces: state.mesAnnonces + annonceNormal,
            isNextListAvailable: annonceNormal.length >= 10));
      }
    } else {
      if (results.isError() is ItemNotFoundFailure) {
        emit(state.copyWith(mesAnnoncesStatus: MesAnnoncesStatus.error));
      } else {
        emit(state.copyWith(mesAnnoncesStatus: MesAnnoncesStatus.error));
      }
    }
  }
}
