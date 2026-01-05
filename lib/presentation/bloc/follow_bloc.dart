import 'package:MIPS/common/constants/constant.dart';
import 'package:MIPS/common/error/failures.dart';
import 'package:MIPS/domain/domain.dart';
import 'package:MIPS/domain/usecases/follow/check_following_usecase.dart';
import 'package:MIPS/domain/usecases/follow/follow_user_usecase.dart';
import 'package:MIPS/domain/usecases/follow/get_annonces_followed_users_count_usecase.dart';
import 'package:MIPS/domain/usecases/follow/get_annonces_followed_users_usecase.dart';
import 'package:MIPS/domain/usecases/follow/get_followers_usecase.dart';
import 'package:MIPS/domain/usecases/follow/get_following_usecase.dart';
import 'package:MIPS/domain/usecases/follow/unfollow_user_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'follow_event.dart';
part 'follow_state.dart';

class FollowBloc extends Bloc<FollowEvent, FollowState> {
  final CheckFollowingUsecase checkFollowingUsecase;
  final FollowUserUsecase followUserUsecase;
  final GetAnnoncesFollowedUsersUsecase getAnnoncesFollowedUsersUsecase;
  final GetFollowersUsecase getFollowersUsecase;
  final GetFollowingUsecase getFollowingUsecase;
  final UnfollowUserUsecase unfollowUserUsecase;
  final GetAnnoncesFollowedUsersCountUsecase
      getAnnoncesFollowedUsersCountUsecase;

  int currentPage = 1;

  FollowBloc({
    required this.checkFollowingUsecase,
    required this.followUserUsecase,
    required this.getAnnoncesFollowedUsersUsecase,
    required this.getFollowersUsecase,
    required this.getFollowingUsecase,
    required this.getAnnoncesFollowedUsersCountUsecase,
    required this.unfollowUserUsecase,
  }) : super(FollowState.initial()) {
    on<CheckFollowingEvent>(_onCheckFollowingEvent);
    on<FollowUserEvent>(_onFollowUserEvent);
    on<LoadAnnonceListOfFollowedUsersCount>(
        _onLoadAnnonceListOfFollowedUsersCount);
    on<LoadMoreListAnnonce>(_onLoadMoreListAnnonce);
    on<LoadAnnonceListFollow>(_onLoadAnnonceListFollow);
    on<FollowersLoadedEvent>(_onFollowersLoadedEvent);
    on<FollowingLoadedEvent>(_onFollowingLoadedEvent);
    on<UnFollowUserEvent>(_onUnFollowUserEvent);
  }

  void _onLoadAnnonceListOfFollowedUsersCount(
      LoadAnnonceListOfFollowedUsersCount event, Emitter emit) async {
    emit(state.copyWith(
        annoncesOfFollowedUsersCountStatus:
            AnnoncesOfFollowedUsersCountStatus.loading));
    var result = await getAnnoncesFollowedUsersCountUsecase();
    if (result.isSuccess()) {
      emit(state.copyWith(
          annoncesOfFollowedUsersCount: result.getSuccess(),
          annoncesOfFollowedUsersCountStatus:
              AnnoncesOfFollowedUsersCountStatus.loaded));
    } else {
      emit(state.copyWith(
          annoncesOfFollowedUsersCountStatus:
              AnnoncesOfFollowedUsersCountStatus.error));
    }
  }

  void _onCheckFollowingEvent(CheckFollowingEvent event, Emitter emit) async {
    emit(state.copyWith(isFollowingStatus: IsFollowingStatus.loading));
    var result = await checkFollowingUsecase(event.id);
    if (result.isSuccess()) {
      emit(state.copyWith(
          isFollowing: result.getSuccess(),
          isFollowingStatus: IsFollowingStatus.loaded));
    } else {
      emit(state.copyWith(isFollowingStatus: IsFollowingStatus.error));
    }
  }

  void _onFollowUserEvent(FollowUserEvent event, Emitter emit) async {
    emit(state.copyWith(isFollowingStatus: IsFollowingStatus.loading));
    var result = await followUserUsecase(event.id);
    if (result.isSuccess()) {
      add(CheckFollowingEvent(id: event.id));
      // emit(state.copyWith(followUserStatus: FollowUserStatus.loaded));
    } else {
      emit(state.copyWith(followUserStatus: FollowUserStatus.error));
    }
  }

  _onLoadAnnonceListFollow(LoadAnnonceListFollow event, Emitter emit) async {
    /// Initialisation lors du premier chargement
    currentPage = event.pageIndex;

    emit(state.copyWith(
        annoncesFollowedStatus: AnnoncesFollowedStatus.loading,
        isNextListAvailable: true));
    var results = await getAnnoncesFollowedUsersUsecase(currentPage, "");
    if (results.isSuccess()) {
      List<Annonce> annonceNormal = [];

      for (var annonce in results.getSuccess()!) {
        if (annonce.annonceType == AnnonceType.general) {
          annonceNormal.add(annonce);
        }
      }
      emit(state.copyWith(
        annoncesFollowedStatus: AnnoncesFollowedStatus.loaded,
        annoncesOfFollowedUsers: annonceNormal,
        isNextListAvailable: annonceNormal.length >= 10,
      ));
    } else {
      if (results.isError() is ItemNotFoundFailure) {
        emit(state.copyWith(
            annoncesFollowedStatus: AnnoncesFollowedStatus.error));
      } else {
        emit(state.copyWith(
            annoncesFollowedStatus: AnnoncesFollowedStatus.error));
      }
    }
  }

  _onLoadMoreListAnnonce(LoadMoreListAnnonce event, Emitter emit) async {
    // emit(state.copyWith(listStatus: ListStatus.loading));
    if (!state.isNextListAvailable) {
      return null;
    }
    currentPage = currentPage + 1;
    var results = await getAnnoncesFollowedUsersUsecase(currentPage, "");
    if (results.isSuccess()) {
      /// Filtrer le type d'annonce
      List<Annonce> annonceNormal = [];
      for (var annonce in results.getSuccess()!) {
        annonceNormal.add(annonce);
      }
      if (annonceNormal.isEmpty) {
        emit(state.copyWith(
            annoncesFollowedStatus: AnnoncesFollowedStatus.loaded,
            isNextListAvailable: false));
      } else {
        emit(state.copyWith(
            annoncesFollowedStatus: AnnoncesFollowedStatus.loaded,
            annoncesOfFollowedUsers:
                state.annoncesOfFollowedUsers + annonceNormal,
            isNextListAvailable: annonceNormal.length >= 10));
      }
    } else {
      if (results.isError() is ItemNotFoundFailure) {
        emit(state.copyWith(
            annoncesFollowedStatus: AnnoncesFollowedStatus.error));
      } else {
        emit(state.copyWith(
            annoncesFollowedStatus: AnnoncesFollowedStatus.error));
      }
    }
  }

  // void _onAnnoncesFollowedEvent(
  //     AnnoncesFollowedEvent event, Emitter emit) async {
  //   emit(
  //       state.copyWith(annoncesFollowedStatus: AnnoncesFollowedStatus.loading));
  //   var result = await getAnnoncesFollowedUsersUsecase(event.page, event.query);
  //   if (result.isSuccess()) {
  //     emit(state.copyWith(
  //         annoncesOfFollowedUsers: result.getSuccess(),
  //         annoncesFollowedStatus: AnnoncesFollowedStatus.loaded));
  //   } else {
  //     emit(
  //         state.copyWith(annoncesFollowedStatus: AnnoncesFollowedStatus.error));
  //   }
  // }

  void _onFollowersLoadedEvent(FollowersLoadedEvent event, Emitter emit) async {
    emit(state.copyWith(followersStatus: FollowersStatus.loading));
    var result = await getFollowersUsecase();
    if (result.isSuccess()) {
      emit(state.copyWith(
          myFollowers: result.getSuccess(),
          followersStatus: FollowersStatus.loaded));
    } else {
      emit(state.copyWith(followersStatus: FollowersStatus.error));
    }
  }

  void _onFollowingLoadedEvent(FollowingLoadedEvent event, Emitter emit) async {
    emit(state.copyWith(followingStatus: FollowingStatus.loading));
    var result = await getFollowingUsecase();
    if (result.isSuccess()) {
      emit(state.copyWith(
          myFollowings: result.getSuccess(),
          followingStatus: FollowingStatus.loaded));
    } else {
      emit(state.copyWith(followingStatus: FollowingStatus.error));
    }
  }

  void _onUnFollowUserEvent(UnFollowUserEvent event, Emitter emit) async {
    // emit(state.copyWith(unFollowUserStatus: UnFollowUserStatus.loading));
    emit(state.copyWith(isFollowingStatus: IsFollowingStatus.loading));
    var result = await unfollowUserUsecase(event.id);
    if (result.isSuccess()) {
      // emit(state.copyWith(unFollowUserStatus: UnFollowUserStatus.loaded));
      add(CheckFollowingEvent(id: event.id));
    } else {
      emit(state.copyWith(unFollowUserStatus: UnFollowUserStatus.error));
    }
  }
}
