part of 'password_guard_bloc.dart';

sealed class PasswordGuardEvent {}

class CheckPasswordEvent extends PasswordGuardEvent {
  final String password;

  CheckPasswordEvent({
    required this.password,
  });
}

class ShowPasswordChangeEvent extends PasswordGuardEvent {
  final bool show;

  ShowPasswordChangeEvent({
    required this.show,
  });
}
