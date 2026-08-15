part of 'profil_bloc.dart';

enum ProfilUserStatus { loading, loaded, error }

enum ProfilUserAnnoncesStatus { loading, loaded, error }

enum ProfilUserAnnoncesCountStatus { loading, loaded, error }

class ProfilState extends Equatable {
  const ProfilState({
    required this.user,
    required this.annonces,
    required this.annoncesCount,
    required this.isNextListAvailable,
    required this.profilUserStatus,
    required this.profilUserAnnoncesStatus,
    required this.profilUserAnnoncesCountStatus,
    required this.error,
  });
  final User user;
  final List<Annonce> annonces;
  final int annoncesCount;
  final bool isNextListAvailable;
  final ProfilUserStatus profilUserStatus;
  final ProfilUserAnnoncesStatus profilUserAnnoncesStatus;
  final ProfilUserAnnoncesCountStatus profilUserAnnoncesCountStatus;
  final String error;

  factory ProfilState.initial() {
    return ProfilState(
      user: User(
        id: 0,
        name: "",
        pseudo: "",
        isMasculin: false,
        photo: "",
        avatarUrl: "",
        phoneNumber: "",
        dateDeNaissance: "",
        lieuResidence: "",
        tokenORPassword: "",
        soldeFAKA: 0,
        mail: "",
      ),
      annonces: [],
      annoncesCount: 0,
      isNextListAvailable: false,
      profilUserStatus: ProfilUserStatus.loading,
      profilUserAnnoncesStatus: ProfilUserAnnoncesStatus.loading,
      profilUserAnnoncesCountStatus: ProfilUserAnnoncesCountStatus.loading,
      error: "",
    );
  }

  ProfilState copyWith({
    User? user,
    List<Annonce>? annonces,
    int? annoncesCount,
    bool? isNextListAvailable,
    ProfilUserStatus? profilUserStatus,
    ProfilUserAnnoncesStatus? profilUserAnnoncesStatus,
    ProfilUserAnnoncesCountStatus? profilUserAnnoncesCountStatus,
    String? error,
  }) {
    return ProfilState(
      user: user ?? this.user,
      annonces: annonces ?? this.annonces,
      annoncesCount: annoncesCount ?? this.annoncesCount,
      isNextListAvailable: isNextListAvailable ?? this.isNextListAvailable,
      profilUserStatus: profilUserStatus ?? this.profilUserStatus,
      profilUserAnnoncesStatus:
          profilUserAnnoncesStatus ?? this.profilUserAnnoncesStatus,
      profilUserAnnoncesCountStatus:
          profilUserAnnoncesCountStatus ?? this.profilUserAnnoncesCountStatus,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
        user,
        annonces,
        annoncesCount,
        isNextListAvailable,
        profilUserStatus,
        profilUserAnnoncesStatus,
        profilUserAnnoncesCountStatus,
        error,
      ];
}
