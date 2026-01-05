part of 'app_bloc.dart';

enum ConnectionStatus { connected, disconnected }

enum SelectedPage { home, favs, newAnnonces, myAnnonces, profile, list }

enum PopupAnnonceStatus { loaded, loading, error }

enum UserStatus {
  loading,
  userConnected,
  none,
  userNotConnected,
  error,
  errorConnection /* error internet connection*/
}

enum StatusForgotPassword {
  validationCodeInprogress,
  validationCodeError,
  validationCodeSentSuccessfully,
  none
}

enum UpdateStatus {
  updateVersionAvailable,
  updateVersionLoading,
  updateVersionNotAvailable
}

enum HistoryFakaListStatus { loaded, loading, error }

enum StatusResetPass { resetInprogress, resetCodeError, resetCodeSuccess, none }

enum StatusTranfertFaka {
  transfertInProgress,
  transfertDone,
  transfertError,
  none
}

enum StatusMessage { loading, loaded, error }

enum StatusMessageDetail { loading, loaded, error }

class AppState {
  final bool isLogged;
  final Locale lang;
  final double textScale;
  final bool isMenuExpanded;
  final ConnectionStatus connectionStatus;
  final User? user;
  final String errorMessage;
  final UserStatus userStatus;
  final SelectedPage selectedPageNav;
  final Categorie selectedMenuCategoriesNavigation;
  final Annonce? annoncePartenaire;
  final Annonce? annonceSponsor;
  final Annonce? annoncePartenaireMenu;
  final Annonce? annonceSponsorMenu;
  final StatusResetPass statusResetPass;
  final StatusTranfertFaka statusTranfertFaka;
  final UpdateStatus updateStatus;
  final StatusForgotPassword statusForgotPassword;
  final PopupAnnonceStatus popupAnnonceStatus;
  final HistoryFakaListStatus historyFakaListStatus;
  final List<TransactionHistory> transactionHistory;
  final List<Message> userMessageList;
  final StatusMessage statusMessage;
  final StatusMessageDetail statusMessageDetail;
  final bool isNextMessageListAvailable;
  final int unreadMessageCount;

  factory AppState.initial(
      {required String lang,
      required double textScale,
      required ConnectionStatus connectionStatus,
      required bool isMenuExpanded}) {
    return AppState(
        updateStatus: UpdateStatus.updateVersionNotAvailable,
        isLogged: false,
        lang: Locale(lang),
        textScale: textScale,
        connectionStatus: connectionStatus,
        userStatus: UserStatus.none,
        isMenuExpanded: isMenuExpanded,
        popupAnnonceStatus: PopupAnnonceStatus.error,
        transactionHistory: [],
        statusMessage: StatusMessage.loaded,
        statusMessageDetail: StatusMessageDetail.loaded,
        userMessageList: [],
        unreadMessageCount: 0,
        isNextMessageListAvailable: true,
        errorMessage: "",
        selectedPageNav: SelectedPage.home,
        user: null);
  }

  AppState(
      {required this.isLogged,
      required this.lang,
      required this.textScale,
      required this.userStatus,
      required this.connectionStatus,
      required this.errorMessage,
      required this.isMenuExpanded,
      required this.selectedPageNav,
      required this.updateStatus,
      required this.isNextMessageListAvailable,
      required this.popupAnnonceStatus,
      required this.transactionHistory,
      required this.userMessageList,
      required this.statusMessage,
      required this.statusMessageDetail,
      required this.unreadMessageCount,
      this.statusTranfertFaka = StatusTranfertFaka.none,
      this.statusResetPass = StatusResetPass.none,
      this.statusForgotPassword = StatusForgotPassword.none,
      this.historyFakaListStatus = HistoryFakaListStatus.loaded,
      this.annoncePartenaire,
      this.annonceSponsor,
      this.annoncePartenaireMenu,
      this.annonceSponsorMenu,
      Categorie? selectedMenuCategoriesNavigation,
      this.user})
      : selectedMenuCategoriesNavigation = selectedMenuCategoriesNavigation ??
            const Categorie(id: -1, name: "", reference: "", isFree: false);

  /// Paramètres force* permettent de forcer la mise à jour ou la réinitialisation des annonces partenaires ou sponsor :
  ///
  /// [forceNullSponsor] : si true, force la mise à jour de l’annonce sponsor principale (annonceSponsor)
  /// [forceNullPartenaire] : si true, force la mise à jour de l’annonce partenaire principale (annoncePartenaire)
  /// [forceNullSponsorMenu] : si true, force la mise à jour de l’annonce sponsor du menu (annonceSponsorMenu)
  /// [forceNullPartenaireMenu] : si true, force la mise à jour de l’annonce partenaire du menu (annoncePartenaireMenu)
  AppState copyWith(
      {bool? isLogged,
      Locale? lang,
      double? textScale,
      ConnectionStatus? connectionStatus,
      User? user,
      UserStatus? userStatus,
      SelectedPage? selectedPageNav,
      Categorie? selectedMenuCategoriesNavigation,
      bool? forceNullSponsor,
      bool? forceNullPartenaire,
      bool? forceNullSponsorMenu,
      bool? forceNullPartenaireMenu,
      bool? isMenuExpanded,
      Annonce? annoncePartenaire,
      Annonce? annonceSponsor,
      Annonce? annoncePartenaireMenu,
      Annonce? annonceSponsorMenu,
      StatusResetPass? statusResetPass,
      StatusTranfertFaka? statusTranfertFaka,
      StatusForgotPassword? statusForgotPassword,
      UpdateStatus? updateStatus,
      PopupAnnonceStatus? popupAnnonceStatus,
      HistoryFakaListStatus? historyFakaListStatus,
      List<TransactionHistory>? transactionHistory,
      List<Message>? userMessageList,
      StatusMessage? statusMessage,
      StatusMessageDetail? statusMessageDetail,
      int? unreadMessageCount,
      bool? isNextMessageListAvailable,
      String? errorMessage}) {
    return AppState(
      updateStatus: updateStatus ?? this.updateStatus,
      isMenuExpanded: isMenuExpanded ?? this.isMenuExpanded,
      statusTranfertFaka: statusTranfertFaka ?? this.statusTranfertFaka,
      statusForgotPassword: statusForgotPassword ?? this.statusForgotPassword,
      transactionHistory: transactionHistory ?? this.transactionHistory,
      statusResetPass: statusResetPass ?? this.statusResetPass,
      userMessageList: userMessageList ?? this.userMessageList,
      statusMessage: statusMessage ?? this.statusMessage,
      unreadMessageCount: unreadMessageCount ?? this.unreadMessageCount,
      statusMessageDetail: statusMessageDetail ?? this.statusMessageDetail,
      isNextMessageListAvailable:
          isNextMessageListAvailable ?? this.isNextMessageListAvailable,
      selectedMenuCategoriesNavigation: selectedMenuCategoriesNavigation ??
          this.selectedMenuCategoriesNavigation,
      isLogged: isLogged ?? this.isLogged,
      lang: lang ?? this.lang,
      textScale: textScale ?? this.textScale,
      connectionStatus: connectionStatus ?? this.connectionStatus,
      user: user ?? this.user,
      selectedPageNav: selectedPageNav ?? this.selectedPageNav,
      userStatus: userStatus ?? this.userStatus,
      historyFakaListStatus:
          historyFakaListStatus ?? this.historyFakaListStatus,
      popupAnnonceStatus: popupAnnonceStatus ?? this.popupAnnonceStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      annoncePartenaire: (forceNullPartenaire ?? false)
          ? annoncePartenaire
          : (annoncePartenaire ?? this.annoncePartenaire),
      annonceSponsor: (forceNullSponsor ?? false)
          ? annonceSponsor
          : (annonceSponsor ?? this.annonceSponsor),
      annoncePartenaireMenu: (forceNullPartenaireMenu ?? false)
          ? annoncePartenaireMenu
          : (annoncePartenaireMenu ?? this.annoncePartenaireMenu),
      annonceSponsorMenu: (forceNullSponsorMenu ?? false)
          ? annonceSponsorMenu
          : (annonceSponsorMenu ?? this.annonceSponsorMenu),
    );
  }
}
