part of 'avatar_bloc.dart';

enum Status { loaded, loading, error }

enum StatusBuy { loading, error, success }

class AvatarState {
  final Status status;
  final StatusBuy statusBuy;
  final List<Avatar> avatarList;
  final Avatar? selectedAvatar;
  final String error;

  const AvatarState(
      {required this.status,
      required this.statusBuy,
      required this.avatarList,
      this.selectedAvatar,
      this.error = ""});

  AvatarState copyWith({
    Status? status,
    StatusBuy? statusBuy,
    List<Avatar>? avatarList,
    Avatar? selectedAvatar,
    String? error,
  }) {
    return AvatarState(
      status: status ?? this.status,
      statusBuy: statusBuy ?? this.statusBuy,
      avatarList: avatarList ?? this.avatarList,
      selectedAvatar: selectedAvatar ?? this.selectedAvatar,
      error: error ?? this.error,
    );
  }
}
