part of 'avis_bloc.dart';

enum Status { loading, loaded, error }

class AvisState {
  final List<Avis> avisList;
  final Avis? selected;
  final Status status;
  final String error;

  const AvisState({
    required this.avisList,
    this.selected,
    required this.status,
    required this.error,
  });

  AvisState copyWith({
    List<Avis>? avisList,
    Avis? selected,
    Status? status,
    String? error,
  }) {
    return AvisState(
      avisList: avisList ?? this.avisList,
      selected: selected ?? this.selected,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }
}
