import 'dart:ui';

import 'package:MIPS/domain/usecases/user/delete_a_message_usecase.dart';
import 'package:MIPS/domain/usecases/user/delete_all_message_usecase.dart';
import 'package:MIPS/presentation/configurations/extension_for_localization.dart';
import 'package:MIPS/presentation/widgets/message_displayer_utils.dart';
import 'package:bloc/bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../common/common.dart';
import '../../data/data.dart';
import '../../domain/domain.dart';
import '../../domain/entities/categorie.dart';
import 'annonce_bloc.dart';

part 'app_event.dart';

part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final TransfertFakaUseCase transfertFakaUseCase;
  final GetTransactionHistoryUsecase getTransactionHistoryUsecase;
  final UserPrefRepositoryImpl userPrefRepositoryImpl;
  final NetworkService networkService;
  final GetUserInfoUseCase getUserInfoUseCase;
  final DeleteUserUseCase deleteUserUseCase;
  final LoginUserUseCase loginUserUseCase;
  final LogoutUserUseCase logoutUserUseCase;
  final RegisterUserUseCase registerUserUseCase;
  final ForgotPasswordUseCase forgotPasswordUseCase;
  final ResetPasswordUseCase resetPasswordUseCase;
  final UpdateUserUseCase updateUserUseCase;
  final ChangePasswordUseCase changePasswordUseCase;
  final GetAnnoncePopupUseCase getAnnoncePopupUseCase;
  final CheckUpdateUseCase checkUpdateUseCase;
  final ViewAllMessageUseCase viewAllMessageUseCase;
  final DeleteAllMessageUsecase deleteAllMessageUsecase;
  AnnonceBloc? annonceBloc;
  String appVersion = "";
  String updateVersion = "";
  Annonce? popUpAnnonce;

  /// Pour la gestion des messages
  final GetUserMessages getUserMessages;
  final ViewAMessageUseCase viewAMessageUseCase;
  final DeleteAMessageUsecase deleteAMessageUseCase;
  final GetUserUnreadMessageCountUsecase getUserUnreadMessageCountUsecase;
  int currentMessagePage = 1;

  AppBloc(
      {required this.userPrefRepositoryImpl,
      required this.networkService,
      required this.viewAMessageUseCase,
      required this.deleteAMessageUseCase,
      required this.viewAllMessageUseCase,
      required this.getUserMessages,
      required this.logoutUserUseCase,
      required this.loginUserUseCase,
      required this.deleteUserUseCase,
      required this.registerUserUseCase,
      required this.resetPasswordUseCase,
      required this.forgotPasswordUseCase,
      required this.transfertFakaUseCase,
      required this.updateUserUseCase,
      required this.checkUpdateUseCase,
      required this.deleteAllMessageUsecase,
      required this.changePasswordUseCase,
      required this.getAnnoncePopupUseCase,
      required this.getTransactionHistoryUsecase,
      required this.getUserInfoUseCase,
      required this.getUserUnreadMessageCountUsecase})
      : super(AppState.initial(
            lang: userPrefRepositoryImpl.getLang(),
            textScale: userPrefRepositoryImpl.getTextScale(),
            isMenuExpanded: userPrefRepositoryImpl.getIsMainMenuExpanded(),
            connectionStatus: ConnectionStatus.connected)) {
    on<InitEvent>(_onInitEvent);
    on<ScaleChangedEvent>(_onScaleChange);
    on<ConnectionChangedEvent>(_onConnectionChangedEvent);
    on<LoginEvent>(_onLoginEvent);
    on<GetUserInfoEvent>(_onGetUserInfoEvent);
    on<LogoutUserEvent>(_onLogoutUserEvent);
    on<ResetPasswordEvent>(_onResetPasswordEvent);
    on<ChangePasswordEvent>(_onChangePasswordEvent);
    on<UpdateUserInfoEvent>(_onUpdateUserInfoEvent);
    on<LoadAnnoncePopupEvent>(_onLoadAnnoncePopupEvent);
    on<CheckNewVersionAppEvent>(_onCheckNewVersionAppEvent);
    on<MainMenuExpandeChangeEvent>(_onMainMenuExpandeChangeEvent);
    on<TransfertFakaEvent>(_onTransfertFakaEvent);
    on<InitTranfertScreen>(_onInitTranfertScreen);
    on<ResetStatusResetPasswordScreenEvent>(
        _onResetStatusResetPasswordScreenEvent);
    on<ForgotPasswordEvent>(_onForgotPasswordEvent);
    on<LoadUserMessageListEvent>(_onLoadUserMessageListEvent);
    on<ViewMessageEvent>(_onViewMessageEvent);
    on<ViewAllMessageEvent>(_onViewAllMessageEvent);
    on<DeleteAllMessageEvent>(_onDeleteAllMessageEvent);
    on<DeleteMessageEvent>(_onDeleteMessageEvent);
    on<GetUnreadMessageCountEvent>(_onGetUnreadMessageCountEvent);
    on<LoadMoreMessageEvent>(_onLoadMoreMessageEvent);
    on<LoadHistoryFakaChangeEvent>(_onLoadHistoryFakaChangeEvent);
    on<RegisterEvent>(_onRegisterEvent);
    on<LanguageChangeEvent>(_onLanguageChangeEvent);
    on<SetSponsAndPartenerEvent>(_onSetSponsAndPartenerEvent);
    on<DeleteUserEvent>(_onDeleteUserEvent);
    on<SetMenuCatNavEvent>(_onSetMenuCatNavEvent);
    on<SetAnnonceSponsorPartenaireNavEvent>(
        _onSetAnnonceSponsorPartenaireNavEvent);
  }

  void _onInitTranfertScreen(InitTranfertScreen event, Emitter emit) async {
    emit(state.copyWith(statusTranfertFaka: StatusTranfertFaka.none));
  }

  void _onResetStatusResetPasswordScreenEvent(
      ResetStatusResetPasswordScreenEvent event, Emitter emit) async {
    emit(state.copyWith(
        statusForgotPassword: StatusForgotPassword.none,
        statusResetPass: StatusResetPass.none));
  }

  void _onSetAnnonceSponsorPartenaireNavEvent(
      SetAnnonceSponsorPartenaireNavEvent event, Emitter emit) {
    AppUtils.showDebugLog(runtimeType,
        "Selected Annonce Part : ${event.annoncesPartenaire?.title}; Spons:  ${event.annoncesSponsor?.title}");

    emit(state.copyWith(
        annonceSponsorMenu: event.annoncesSponsor,
        annoncePartenaireMenu: event.annoncesPartenaire,
        forceNullPartenaireMenu: true,
        forceNullSponsorMenu: true));
  }

  void _onSetMenuCatNavEvent(SetMenuCatNavEvent event, Emitter emit) {
    AppUtils.showDebugLog(
        runtimeType, "Selected Menu: ${event.seletectMenuCat}");
    annonceBloc = event.annonceBloc;

    emit(state.copyWith(
      selectedMenuCategoriesNavigation: event.seletectMenuCat,
    ));
  }

  void _onLanguageChangeEvent(LanguageChangeEvent event, Emitter emit) async {
    await userPrefRepositoryImpl.setLang(event.langCode);
    emit(state.copyWith(lang: Locale(event.langCode)));
  }

  void _onLoadUserMessageListEvent(
      LoadUserMessageListEvent event, Emitter emit) async {
    currentMessagePage = 1;
    emit(state
        .copyWith(statusMessage: StatusMessage.loading, userMessageList: []));
    var result = await getUserMessages(currentMessagePage);
    if (result.isSuccess()) {
      emit(state.copyWith(
          statusMessage: StatusMessage.loaded,
          userMessageList: result.getSuccess(),
          isNextMessageListAvailable: result.getSuccess()!.length >= 10));
    } else {
      emit(state.copyWith(statusMessage: StatusMessage.error));
    }
  }

  void _onViewMessageEvent(ViewMessageEvent event, Emitter emit) async {
    emit(state.copyWith(statusMessageDetail: StatusMessageDetail.loading));
    var result = await viewAMessageUseCase(event.id);
    if (result.isSuccess()) {
      /// Recupere le nombre de message non lu
      add(GetUnreadMessageCountEvent());
      List<Message> userMessageList = state.userMessageList;
      int indexOfUpdatedMessage = userMessageList.indexWhere(
        (element) => element.id == event.id,
      );
      userMessageList[indexOfUpdatedMessage] =
          userMessageList[indexOfUpdatedMessage].copyWith(isViewed: true);
      emit(state.copyWith(
          statusMessageDetail: StatusMessageDetail.loaded,
          userMessageList: userMessageList));
    } else {
      emit(state.copyWith(statusMessageDetail: StatusMessageDetail.error));
    }
  }

  void _onViewAllMessageEvent(ViewAllMessageEvent event, Emitter emit) async {
    emit(state.copyWith(statusMessageDetail: StatusMessageDetail.loading));
    var result = await viewAllMessageUseCase();
    if (result.isSuccess()) {
      /// Recupere le nombre de message non lu
      add(GetUnreadMessageCountEvent());

      /// Recharge tous les messages
      add(LoadUserMessageListEvent());
      emit(state.copyWith(statusMessageDetail: StatusMessageDetail.loaded));
    } else {
      emit(state.copyWith(statusMessageDetail: StatusMessageDetail.error));
    }
  }

  void _onDeleteAllMessageEvent(
      DeleteAllMessageEvent event, Emitter emit) async {
    emit(state.copyWith(statusMessageDetail: StatusMessageDetail.loading));
    var result = await deleteAllMessageUsecase();
    if (result.isSuccess()) {
      /// Recupere le nombre de message non lu
      add(GetUnreadMessageCountEvent());

      /// Recharge tous les messages
      add(LoadUserMessageListEvent());
      emit(state.copyWith(statusMessageDetail: StatusMessageDetail.loaded));
    } else {
      emit(state.copyWith(statusMessageDetail: StatusMessageDetail.error));
    }
  }

  void _onDeleteMessageEvent(DeleteMessageEvent event, Emitter emit) async {
    emit(state.copyWith(statusMessageDetail: StatusMessageDetail.loading));
    var result = await deleteAMessageUseCase(event.id);
    if (result.isSuccess()) {
      /// Recupere le nombre de message non lu
      add(GetUnreadMessageCountEvent());

      /// Recharge tous les messages
      add(LoadUserMessageListEvent());
      emit(state.copyWith(statusMessageDetail: StatusMessageDetail.loaded));
    } else {
      emit(state.copyWith(statusMessageDetail: StatusMessageDetail.error));
    }
  }

  void _onGetUnreadMessageCountEvent(
      GetUnreadMessageCountEvent event, Emitter emit) async {
    /// Recupere le nombre de message non lu
    if (state.isLogged) {
      var resultUnreadMessageCount = await getUserUnreadMessageCountUsecase();
      if (resultUnreadMessageCount.isSuccess()) {
        emit(state.copyWith(
          unreadMessageCount: resultUnreadMessageCount.getSuccess(),
        ));
      }
    }
  }

  void _onLoadMoreMessageEvent(LoadMoreMessageEvent event, Emitter emit) async {
    if (!state.isNextMessageListAvailable) {
      return;
    }
    currentMessagePage = currentMessagePage + 1;
    emit(state.copyWith(statusMessage: StatusMessage.loading));
    var result = await getUserMessages(currentMessagePage);
    if (result.isSuccess()) {
      emit(state.copyWith(
          statusMessage: StatusMessage.loaded,
          userMessageList: state.userMessageList + result.getSuccess()!,
          isNextMessageListAvailable: result.getSuccess()!.length >= 10));
    } else {
      emit(state.copyWith(statusMessage: StatusMessage.error));
    }
  }

  void _onDeleteUserEvent(DeleteUserEvent event, Emitter emit) async {
    emit(state.copyWith(userStatus: UserStatus.loading));
    var result = await deleteUserUseCase();
    if (result.isSuccess()) {
      MessageDisplayerUtils.showToastMessage(
          GlobalContextService.snackbarKey.currentContext!.appLoc.delete_done);
      emit(state.copyWith(
        isLogged: false,
        userStatus: UserStatus.userNotConnected,
      ));
    } else {
      MessageDisplayerUtils.showToastMessage(GlobalContextService
          .snackbarKey.currentContext!.appLoc.error_operation);
      emit(state.copyWith(userStatus: UserStatus.userConnected));
    }
  }

  void _onMainMenuExpandeChangeEvent(
      MainMenuExpandeChangeEvent event, Emitter emit) async {
    userPrefRepositoryImpl
        .setIsMainMenuExpanded(!userPrefRepositoryImpl.getIsMainMenuExpanded());
    emit(state.copyWith(
        isMenuExpanded: userPrefRepositoryImpl.getIsMainMenuExpanded()));
  }

  void _onCheckNewVersionAppEvent(
      CheckNewVersionAppEvent event, Emitter emit) async {
    emit(state.copyWith(updateStatus: UpdateStatus.updateVersionLoading));
    var result = await checkUpdateUseCase(appVersion);
    if (result.isSuccess()) {
      updateVersion = result.getSuccess()!;

      emit(state.copyWith(updateStatus: UpdateStatus.updateVersionAvailable));
    } else {
      emit(
          state.copyWith(updateStatus: UpdateStatus.updateVersionNotAvailable));
    }
  }

  void _onLoadHistoryFakaChangeEvent(
      LoadHistoryFakaChangeEvent event, Emitter emit) async {
    emit(state.copyWith(historyFakaListStatus: HistoryFakaListStatus.loading));
    var result = await getTransactionHistoryUsecase(event.page);
    if (result.isSuccess()) {
      emit(state.copyWith(
          historyFakaListStatus: HistoryFakaListStatus.loaded,
          transactionHistory: result.getSuccess()));
    } else {
      emit(state.copyWith(historyFakaListStatus: HistoryFakaListStatus.error));
    }
  }

  void _onLoadAnnoncePopupEvent(
      LoadAnnoncePopupEvent event, Emitter emit) async {
    emit(state.copyWith(popupAnnonceStatus: PopupAnnonceStatus.loading));
    if (popUpAnnonce != null) {
      emit(state.copyWith(popupAnnonceStatus: PopupAnnonceStatus.loaded));
    } else {
      var annoncePopupResult = await getAnnoncePopupUseCase();

      /// Affiche popup
      if (annoncePopupResult.isSuccess()) {
        emit(state.copyWith(popupAnnonceStatus: PopupAnnonceStatus.loaded));
        popUpAnnonce = annoncePopupResult.getSuccess();
      } else {
        emit(state.copyWith(popupAnnonceStatus: PopupAnnonceStatus.error));
      }
    }
  }

  void _onTransfertFakaEvent(TransfertFakaEvent event, Emitter emit) async {
    emit(state.copyWith(
        statusTranfertFaka: StatusTranfertFaka.transfertInProgress));
    var result = await transfertFakaUseCase(
        event.phoneReceiver, event.amount, event.motif);
    if (result.isSuccess()) {
      emit(state.copyWith(
          statusTranfertFaka: StatusTranfertFaka.transfertDone,
          user: result.getSuccess()));
    } else {
      emit(state.copyWith(
          statusTranfertFaka: StatusTranfertFaka.transfertError,
          errorMessage: result.getError()?.message));
    }
  }

  void _onResetPasswordEvent(ResetPasswordEvent event, Emitter emit) async {
    emit(state.copyWith(statusResetPass: StatusResetPass.resetInprogress));
    var result =
        await resetPasswordUseCase(event.validationCode, event.newPassword);
    if (result.isSuccess()) {
      emit(state.copyWith(statusResetPass: StatusResetPass.resetCodeSuccess));
      userPrefRepositoryImpl.setToken(result.getSuccess()!.tokenORPassword);

      /// Récupère les informations utilisateur après changement
      add(GetUserInfoEvent(showWelcomeMessage: false));
    } else {
      emit(state.copyWith(
          statusResetPass: StatusResetPass.resetCodeError,
          errorMessage: result.getError()?.message));
    }
  }

  void _onChangePasswordEvent(ChangePasswordEvent event, Emitter emit) async {
    /// TO DO:
    /// /!\ il faut gérer correctement la structure du résultat retourné
    emit(state.copyWith(statusResetPass: StatusResetPass.resetInprogress));
    var result =
        await changePasswordUseCase(event.oldPassword, event.newPassword);
    if (result.isSuccess()) {
      emit(state.copyWith(statusResetPass: StatusResetPass.resetCodeSuccess));
      userPrefRepositoryImpl.setToken(result.getSuccess()!.tokenORPassword);

      /// Récupère les informations de l’utilisateur après changement
      add(GetUserInfoEvent(showWelcomeMessage: false));
    } else {
      emit(state.copyWith(
          statusResetPass: StatusResetPass.resetCodeError,
          errorMessage: result.getError()?.message));
    }
  }

  void _onForgotPasswordEvent(ForgotPasswordEvent event, Emitter emit) async {
    emit(state.copyWith(
        statusForgotPassword: StatusForgotPassword.validationCodeInprogress));

    var result = await forgotPasswordUseCase(event.email);

    if (result.isSuccess()) {
      emit(state.copyWith(
          statusForgotPassword:
              StatusForgotPassword.validationCodeSentSuccessfully));
    } else {
      emit(state.copyWith(
          statusForgotPassword: StatusForgotPassword.validationCodeError,
          errorMessage: result.getError()?.message));
    }
  }

  void _onSetSponsAndPartenerEvent(
      SetSponsAndPartenerEvent event, Emitter emit) async {
    emit(state.copyWith(
        forceNullPartenaire: true,
        forceNullSponsor: true,
        annoncePartenaire: event.annoncePartenaire,
        annonceSponsor: event.annonceSponsor));
  }

  void _onRegisterEvent(RegisterEvent event, Emitter emit) async {
    emit(state.copyWith(userStatus: UserStatus.loading));
    var result = await registerUserUseCase(User(
        id: 0,
        name: event.name,
        pseudo: event.pseudo,
        isMasculin: event.isMasculin,
        photo: "",
        avatarUrl: "",
        phoneNumber: event.phoneNumber,
        dateDeNaissance: event.anneeNaissance,
        lieuResidence: event.lieuResidence,
        tokenORPassword: event.tokenORPassword,
        soldeFAKA: 0,
        mail: event.mail));
    emit(state.copyWith(userStatus: UserStatus.loading));
    if (result.isSuccess()) {
      userPrefRepositoryImpl.setToken(result.getSuccess()!.tokenORPassword);

      ///Get user info after registration
      add(GetUserInfoEvent());
    } else {
      if (result.getError() is NoConnectionFailure) {
        emit(state.copyWith(userStatus: UserStatus.errorConnection));
      } else {
        emit(state.copyWith(
            userStatus: UserStatus.error,
            errorMessage: result.getError()?.message));
      }
    }
  }

  void _onUpdateUserInfoEvent(UpdateUserInfoEvent event, Emitter emit) async {
    emit(state.copyWith(userStatus: UserStatus.loading));

    var result = await updateUserUseCase(state.user!.copyWith(
        lieuResidence: event.province, mail: event.mail, pseudo: event.pseudo));
    emit(state.copyWith(userStatus: UserStatus.loading));
    if (result.isSuccess()) {
      emit(state.copyWith(
          userStatus: UserStatus.userConnected, user: result.getSuccess()));
    } else {
      if (result.getError() is NoConnectionFailure) {
        emit(state.copyWith(userStatus: UserStatus.errorConnection));
      } else {
        emit(state.copyWith(
            userStatus: UserStatus.error,
            errorMessage: result.getError()?.message));
      }
    }
  }

  void _onLogoutUserEvent(LogoutUserEvent event, Emitter emit) async {
    emit(state.copyWith(userStatus: UserStatus.loading));
    var result = await logoutUserUseCase();
    if (result.isSuccess()) {
      MessageDisplayerUtils.showToastMessage(
          GlobalContextService.snackbarKey.currentContext!.appLoc.logout_done);
      emit(state.copyWith(
        isLogged: false,
        userStatus: UserStatus.userNotConnected,
      ));
    } else {
      MessageDisplayerUtils.showToastMessage(GlobalContextService
          .snackbarKey.currentContext!.appLoc.error_operation);
    }
  }

  void _onGetUserInfoEvent(GetUserInfoEvent event, Emitter emit) async {
    if (event.showWelcomeMessage) {
      emit(state.copyWith(userStatus: UserStatus.loading));
    }
    var result = await getUserInfoUseCase();
    if (result.isSuccess()) {
      /// Recupere le nombre de message non lu
      add(GetUnreadMessageCountEvent());
      emit(state.copyWith(
          isLogged: true,
          userStatus: event.showWelcomeMessage
              ? UserStatus.userConnected
              : UserStatus.none,
          user: result.getSuccess()));
    } else {
      if (result.getError() is NoConnectionFailure) {
        Future.delayed(
          const Duration(seconds: 30),
          () {
            add(GetUserInfoEvent());
          },
        );
      } else {
        if (event.showWelcomeMessage) {
          emit(state.copyWith(
            userStatus: UserStatus.error,
            isLogged: false,
          ));
        }
      }
    }
  }

  void _onLoginEvent(LoginEvent event, Emitter emit) async {
    emit(state.copyWith(userStatus: UserStatus.loading));
    var result =
        await loginUserUseCase(event.login, event.password, event.stayLogged);
    if (result.isSuccess()) {
      userPrefRepositoryImpl.setToken(result.getSuccess()!.tokenORPassword);

      ///Get user info after login
      add(GetUserInfoEvent());
    } else {
      if (result.getError() is NoConnectionFailure) {
        emit(state.copyWith(userStatus: UserStatus.errorConnection));
      } else {
        emit(state.copyWith(userStatus: UserStatus.error));
      }
    }
  }

  void _onConnectionChangedEvent(ConnectionChangedEvent event, Emitter emit) {
    emit(state.copyWith(
        connectionStatus: event.isReconnected
            ? ConnectionStatus.connected
            : ConnectionStatus.disconnected));

    /// Decommenter si besoin d'afficher le changement de status de connexion
    /* MessageDisplayerUtils.showConnectionChangeToast(event.isReconnected
        ? ConnectionStatus.connected
        : ConnectionStatus.disconnected);*/
  }

  void _onInitEvent(InitEvent event, Emitter emit) async {
    /// Enregistre le service listener
    networkService.runNetworkStateListener(() {
      add(ConnectionChangedEvent(isReconnected: true));
    }, () {
      add(ConnectionChangedEvent(isReconnected: false));
    });
    // userPrefRepositoryImpl.setToken("");

    /// Connecte l'utilisateur
    var result = await getUserInfoUseCase();
    if (result.isSuccess()) {
      /// Si utilisateur connecté, recupère le nombre de message non lu
      add(GetUnreadMessageCountEvent());
      emit(state.copyWith(
          isLogged: true,
          userStatus: UserStatus.userConnected,
          user: result.getSuccess()));
    }

    /// Récupération des informations de version de l’application
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    appVersion = packageInfo.version;
    emit(state.copyWith(popupAnnonceStatus: PopupAnnonceStatus.loading));
    var annoncePopupResult = await getAnnoncePopupUseCase();

    ///  Affiche le popup
    if (annoncePopupResult.isSuccess()) {
      emit(state.copyWith(popupAnnonceStatus: PopupAnnonceStatus.loaded));
      popUpAnnonce = annoncePopupResult.getSuccess();
    } else {
      emit(state.copyWith(popupAnnonceStatus: PopupAnnonceStatus.error));
    }

    ///  Vérifie s'il y a une nouvelle version
    add(CheckNewVersionAppEvent());
  }

  void _onScaleChange(ScaleChangedEvent event, Emitter emit) {
    double textScale = event.scaleValue;
    if (event.scaleValue <= 0.2) {
      textScale = 0.2;
    } else if (event.scaleValue >= 3.0) {
      textScale = 2.0;
    }
    userPrefRepositoryImpl.setTextScale(textScale);
    emit(state.copyWith(textScale: textScale));
  }
}
