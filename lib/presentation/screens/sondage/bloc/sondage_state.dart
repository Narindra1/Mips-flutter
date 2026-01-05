part of 'sondage_bloc.dart';

enum Status { loaded, loading, error }

enum StatusSubmitting { submitInProgress, submitSent, submitError }

class SondageState {
  final Status status;
  final StatusSubmitting statusSubmitting;
  final List<Sondage> sondagesList;
  final Sondage? selectedSondage;
  final String error;

  const SondageState(
      {required this.status,
      required this.statusSubmitting,
      required this.sondagesList,
      this.selectedSondage,
      required this.error});

  SondageState copyWith({
    Status? status,
    StatusSubmitting? statusSubmitting,
    List<Sondage>? sondagesList,
    Sondage? selectedSondage,
    String? error,
  }) {
    return SondageState(
      status: status ?? this.status,
      statusSubmitting: statusSubmitting ?? this.statusSubmitting,
      sondagesList: sondagesList ?? this.sondagesList,
      selectedSondage: selectedSondage ?? this.selectedSondage,
      error: error ?? this.error,
    );
  }
}
