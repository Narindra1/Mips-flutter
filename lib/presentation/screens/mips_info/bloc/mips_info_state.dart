part of 'mips_info_bloc.dart';

enum MipsInfoStatus { loaded, loading, error }

enum MoreInfoStatus { loaded, loading, error }

class MipsInfoState extends Equatable {
  const MipsInfoState({
    required this.avisList,
    required this.moreInfoList,
    required this.mipsInfoStatus,
    required this.moreInfoStatus,
    required this.error,
  });
  final List<Avis> avisList;
  final List<MoreInfo> moreInfoList;
  final MipsInfoStatus mipsInfoStatus;
  final MoreInfoStatus moreInfoStatus;
  final String error;

  MipsInfoState copyWith({
    List<Avis>? avisList,
    List<MoreInfo>? moreInfoList,
    MipsInfoStatus? mipsInfoStatus,
    MoreInfoStatus? moreInfoStatus,
    String? error,
  }) {
    return MipsInfoState(
      avisList: avisList ?? this.avisList,
      moreInfoList: moreInfoList ?? this.moreInfoList,
      mipsInfoStatus: mipsInfoStatus ?? this.mipsInfoStatus,
      moreInfoStatus: moreInfoStatus ?? this.moreInfoStatus,
      error: error ?? this.error,
    );
  }

  @override
  List<Object> get props => [
        avisList,
        avisList,
        mipsInfoStatus,
        moreInfoStatus,
        error,
      ];
}
