part of 'mips_info_bloc.dart';

sealed class MipsInfoEvent extends Equatable {
  const MipsInfoEvent();

  @override
  List<Object> get props => [];
}

class LoadMipsInfoListEvent extends MipsInfoEvent {}
