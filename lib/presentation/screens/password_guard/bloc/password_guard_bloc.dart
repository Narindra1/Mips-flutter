import 'package:bloc/bloc.dart';

import '../../../../domain/usecases/user/check_password_usecase.dart';

part 'password_guard_event.dart';

part 'password_guard_state.dart';

class PasswordGuardBloc extends Bloc<PasswordGuardEvent, PasswordGuardState> {
  final CheckPasswordUseCase checkPasswordUseCase;

  PasswordGuardBloc({required this.checkPasswordUseCase})
      : super(const PasswordGuardState(
            status: Status.initialized,
            errorMessage: "",
            showPassword: false)) {
    on<CheckPasswordEvent>((event, emit) async {
      emit(state.copyWith(status: Status.checking));
      var result = await checkPasswordUseCase(event.password);
      if (result.isSuccess()) {
        emit(state.copyWith(status: Status.passed));
      } else {
        emit(state.copyWith(
            status: Status.error, errorMessage: result.getError()?.message));
      }
    });
    on<ShowPasswordChangeEvent>((event, emit) async {
      emit(state.copyWith(showPassword: event.show));
    });
  }
}
