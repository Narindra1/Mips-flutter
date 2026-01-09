part of 'mips_info_bloc.dart';

enum Status { loaded, loading, error }

class MipsInfoState extends Equatable {
  const MipsInfoState({
    required this.avisList,
    required this.status,
    required this.error,
  });
  final List<Avis> avisList;
  final Status status;
  final String error;

  MipsInfoState copyWith({
    List<Avis>? avisList,
    Status? status,
    String? error,
  }) {
    return MipsInfoState(
      avisList: avisList ?? this.avisList,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }

  @override
  List<Object> get props => [avisList, status, error];
}
