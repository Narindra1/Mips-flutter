part of 'mips_info_bloc.dart';

enum MipsInfoStatus { loaded, loading, error }

class MipsInfoState extends Equatable {
  const MipsInfoState({
    required this.avisList,
    required this.mipsInfoStatus,
    required this.error,
  });
  final List<Avis> avisList;
  final MipsInfoStatus mipsInfoStatus;
  final String error;

  MipsInfoState copyWith({
    List<Avis>? avisList,
    MipsInfoStatus? mipsInfoStatus,
    String? error,
  }) {
    return MipsInfoState(
      avisList: avisList ?? this.avisList,
      mipsInfoStatus: mipsInfoStatus ?? this.mipsInfoStatus,
      error: error ?? this.error,
    );
  }

  @override
  List<Object> get props => [avisList, mipsInfoStatus, error];
}
