part of 'menu_screen_bloc.dart';

enum Status { loaded, loading, pageNotFound, error }

class MenuScreenState {
  final Menu? screenEntity;
  final String lang;
  final Status status;
  final Failure failure;

  const MenuScreenState(
      {required this.lang,
      this.screenEntity,
      required this.status,
      required this.failure});

  factory MenuScreenState.initial(String lang) {
    return MenuScreenState(
        lang: lang,
        failure: const ServerFailure(),
        screenEntity: const Menu(
            id: 0,
            title: "MIPS",
            // title: "Mahafaka",
            menusChildList: [],
            isFavs: false,
            isFree: false,
            reference: "",
            annoncePartner: null,
            annonceSponsor: null),
        status: Status.loading);
  }

  MenuScreenState copyWith({
    Menu? screenEntity,
    String? lang,
    Status? status,
    Failure? failure,
  }) {
    return MenuScreenState(
      screenEntity: screenEntity ?? this.screenEntity,
      lang: lang ?? this.lang,
      status: status ?? this.status,
      failure: failure ?? this.failure,
    );
  }
}
