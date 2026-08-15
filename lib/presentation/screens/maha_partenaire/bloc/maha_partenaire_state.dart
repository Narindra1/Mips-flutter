part of 'maha_partenaire_bloc.dart';

enum Status { loaded, loading, error }

class MahaPartenaireState {
  final List<MahaPartenaireElt> mahaPartenaireElts;
  final String error;
  final Status status;

  const MahaPartenaireState({
    required this.mahaPartenaireElts,
    required this.error,
    required this.status,
  });

  MahaPartenaireState copyWith({
    List<MahaPartenaireElt>? mahaPartenaireElts,
    String? error,
    Status? status,
  }) {
    return MahaPartenaireState(
      mahaPartenaireElts: mahaPartenaireElts ?? this.mahaPartenaireElts,
      error: error ?? this.error,
      status: status ?? this.status,
    );
  }
}
