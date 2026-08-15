part of 'mes_annonces_screen_bloc.dart';

enum MesAnnoncesStatus { loaded, loading, error }

enum MesAnnoncesCountStatus { loaded, loading, error }

class MesAnnoncesScreenState {
  final List<Annonce> mesAnnonces;
  final int mesAnnoncesCount;
  final MesAnnoncesCountStatus mesAnnoncesCountStatus;
  final MesAnnoncesStatus mesAnnoncesStatus;
  final bool isNextListAvailable;
  final String error;

  const MesAnnoncesScreenState({
    required this.mesAnnonces,
    required this.mesAnnoncesCount,
    required this.mesAnnoncesCountStatus,
    required this.mesAnnoncesStatus,
    required this.isNextListAvailable,
    required this.error,
  });

  factory MesAnnoncesScreenState.initial() {
    return MesAnnoncesScreenState(
      mesAnnonces: [],
      mesAnnoncesCount: 0,
      mesAnnoncesCountStatus: MesAnnoncesCountStatus.loading,
      mesAnnoncesStatus: MesAnnoncesStatus.loading,
      isNextListAvailable: false,
      error: "",
    );
  }

  MesAnnoncesScreenState copyWith({
    List<Annonce>? mesAnnonces,
    int? mesAnnoncesCount,
    MesAnnoncesCountStatus? mesAnnoncesCountStatus,
    MesAnnoncesStatus? mesAnnoncesStatus,
    bool? isNextListAvailable,
    String? error,
  }) {
    return MesAnnoncesScreenState(
      mesAnnonces: mesAnnonces ?? this.mesAnnonces,
      mesAnnoncesCount: mesAnnoncesCount ?? this.mesAnnoncesCount,
      mesAnnoncesCountStatus:
          mesAnnoncesCountStatus ?? this.mesAnnoncesCountStatus,
      mesAnnoncesStatus: mesAnnoncesStatus ?? this.mesAnnoncesStatus,
      isNextListAvailable: isNextListAvailable ?? this.isNextListAvailable,
      error: error ?? this.error,
    );
  }
}
