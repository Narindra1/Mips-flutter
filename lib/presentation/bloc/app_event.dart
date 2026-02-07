part of 'app_bloc.dart';

class AppEvent {}

class ScaleChangedEvent extends AppEvent {
  final double scaleValue;

  ScaleChangedEvent(this.scaleValue);
}

class InitTranfertScreen extends AppEvent {}

class InitEvent extends AppEvent {}

class LoadAnnoncePopupEvent extends AppEvent {}

class LoginEvent extends AppEvent {
  final String login;
  final String password;
  final bool stayLogged;

  LoginEvent(
      {required this.login, required this.password, required this.stayLogged});
}

class RegisterEvent extends AppEvent {
  final String name;
  final String pseudo;
  final bool isMasculin;
  final String phoneNumber;
  final String anneeNaissance;
  final String lieuResidence;
  final String tokenORPassword;
  final String mail;

  RegisterEvent({
    required this.name,
    required this.pseudo,
    required this.isMasculin,
    required this.phoneNumber,
    required this.anneeNaissance,
    required this.lieuResidence,
    required this.tokenORPassword,
    required this.mail,
  });
}

class GetUserInfoEvent extends AppEvent {
  final bool showWelcomeMessage;

  GetUserInfoEvent({
    this.showWelcomeMessage = true,
  });
}

class DeleteUserEvent extends AppEvent {}

class ConnectionChangedEvent extends AppEvent {
  final bool isReconnected;

  ConnectionChangedEvent({
    required this.isReconnected,
  });
}

class TransfertFakaEvent extends AppEvent {
  final String phoneReceiver;
  final int amount;
  final String motif;

  TransfertFakaEvent({
    required this.phoneReceiver,
    required this.amount,
    required this.motif,
  });
}

class ForgotPasswordEvent extends AppEvent {
  final String email;

  ForgotPasswordEvent({
    required this.email,
  });
}

class ResetStatusResetPasswordScreenEvent extends AppEvent {}

class ResetPasswordEvent extends AppEvent {
  final String validationCode;
  final String newPassword;

  ResetPasswordEvent({
    required this.validationCode,
    required this.newPassword,
  });
}

class ChangePasswordEvent extends AppEvent {
  final String oldPassword;
  final String newPassword;

  ChangePasswordEvent({
    required this.oldPassword,
    required this.newPassword,
  });
}

class UpdateUserInfoEvent extends AppEvent {
  final String pseudo;
  final String mail;
  final String province;

  UpdateUserInfoEvent({
    required this.pseudo,
    required this.mail,
    required this.province,
  });
}

class SetMenuCatNavEvent extends AppEvent {
  final Categorie seletectMenuCat;
  final AnnonceBloc annonceBloc;

  SetMenuCatNavEvent({
    required this.seletectMenuCat,
    required this.annonceBloc,
  });
}

class SetAnnonceSponsorPartenaireNavEvent extends AppEvent {
  final Annonce? annoncesPartenaire;
  final Annonce? annoncesSponsor;

  SetAnnonceSponsorPartenaireNavEvent(
      {required this.annoncesSponsor, required this.annoncesPartenaire});
}

class LogoutUserEvent extends AppEvent {}

class CheckNewVersionAppEvent extends AppEvent {}

class LanguageChangeEvent extends AppEvent {
  final String langCode;

  LanguageChangeEvent({
    required this.langCode,
  });
}

class SetSponsAndPartenerEvent extends AppEvent {
  final Annonce? annonceSponsor;
  final Annonce? annoncePartenaire;

  SetSponsAndPartenerEvent(
      {required this.annonceSponsor, required this.annoncePartenaire});
}

class MainMenuExpandeChangeEvent extends AppEvent {}

class LoadHistoryFakaChangeEvent extends AppEvent {
  final int page;

  LoadHistoryFakaChangeEvent({
    required this.page,
  });
}

class LoadUserMessageListEvent extends AppEvent {}

class LoadMoreMessageEvent extends AppEvent {}

class ViewMessageEvent extends AppEvent {
  final int id;

  ViewMessageEvent({required this.id});
}

class DeleteMessageEvent extends AppEvent {
  final int id;

  DeleteMessageEvent({required this.id});
}

class ViewAllMessageEvent extends AppEvent {}

class GetUnreadMessageCountEvent extends AppEvent {}
