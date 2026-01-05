part of 'password_guard_bloc.dart';

enum Status { checking, error, passed, initialized }

class PasswordGuardState {
  final Status status;
  final String errorMessage;
  final bool showPassword;

  const PasswordGuardState(
      {required this.status,
      required this.errorMessage,
      required this.showPassword});

  PasswordGuardState copyWith({
    Status? status,
    String? errorMessage,
    bool? showPassword,
  }) {
    return PasswordGuardState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      showPassword: showPassword ?? this.showPassword,
    );
  }
}
