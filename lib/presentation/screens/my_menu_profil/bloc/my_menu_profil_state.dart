part of 'my_menu_profil_bloc.dart';

enum Status { error, loaded, loading }

enum AnnoncesFavorisStatus { error, loaded, loading }

enum AnnoncesFavorisCountStatus { error, loaded, loading }

class MyMenuProfilState extends Equatable {
  final UserMenuProfil userMenuProfil;
  final List<Annonce> annoncesFavoris;
  final int annoncesFavorisCount;
  final AnnoncesFavorisStatus annoncesFavorisStatus;
  final AnnoncesFavorisCountStatus annoncesFavorisCountStatus;
  final bool isNextListAvailable;
  final Status status;
  final String error;

  const MyMenuProfilState({
    required this.userMenuProfil,
    required this.annoncesFavoris,
    required this.annoncesFavorisCount,
    required this.annoncesFavorisStatus,
    required this.annoncesFavorisCountStatus,
    required this.isNextListAvailable,
    required this.status,
    required this.error,
  });

  factory MyMenuProfilState.initial() {
    return const MyMenuProfilState(
      userMenuProfil: UserMenuProfil(
        annonceFavoris: [],
        annonceCount: 0,
        menuFavoris: [],
      ),
      annoncesFavoris: [],
      annoncesFavorisCount: 0,
      annoncesFavorisStatus: AnnoncesFavorisStatus.loading,
      annoncesFavorisCountStatus: AnnoncesFavorisCountStatus.loading,
      isNextListAvailable: false,
      status: Status.loading,
      error: "",
    );
  }

  MyMenuProfilState copyWith({
    UserMenuProfil? userMenuProfil,
    List<Annonce>? annoncesFavoris,
    int? annoncesFavorisCount,
    AnnoncesFavorisStatus? annoncesFavorisStatus,
    AnnoncesFavorisCountStatus? annoncesFavorisCountStatus,
    bool? isNextListAvailable,
    Status? status,
    String? error,
  }) {
    return MyMenuProfilState(
      userMenuProfil: userMenuProfil ?? this.userMenuProfil,
      annoncesFavoris: annoncesFavoris ?? this.annoncesFavoris,
      annoncesFavorisCount: annoncesFavorisCount ?? this.annoncesFavorisCount,
      annoncesFavorisStatus:
          annoncesFavorisStatus ?? this.annoncesFavorisStatus,
      annoncesFavorisCountStatus:
          annoncesFavorisCountStatus ?? this.annoncesFavorisCountStatus,
      isNextListAvailable: isNextListAvailable ?? this.isNextListAvailable,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }

  @override
  List<Object> get props => [
        userMenuProfil,
        annoncesFavoris,
        annoncesFavorisCount,
        annoncesFavorisStatus,
        annoncesFavorisCountStatus,
        isNextListAvailable,
        status,
        error,
      ];
}
