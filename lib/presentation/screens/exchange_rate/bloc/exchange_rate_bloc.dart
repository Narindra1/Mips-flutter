import 'package:MIPS/domain/entities/devise.dart';
import 'package:MIPS/domain/usecases/exchange_rate/get_exchange_rate_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'exchange_rate_event.dart';
part 'exchange_rate_state.dart';

class ExchangeRateBloc extends Bloc<ExchangeRateEvent, ExchangeRateState> {
  final GetExchangeRateUsecase getExchangeRateUsecase;

  ExchangeRateBloc({required this.getExchangeRateUsecase})
      : super(ExchangeRateState(
          devise: [],
          date: DateTime.now(),
          source: '',
          status: Status.loading,
          error: '',
        )) {
    on<ExchangeRateLoaded>(_onExchangeRateLoaded);
  }
  void _onExchangeRateLoaded(ExchangeRateLoaded event, Emitter emit) async {
    emit(state.copyWith(status: Status.loading));
    var result = await getExchangeRateUsecase();
    if (result.isSuccess()) {
      emit(state.copyWith(
        status: Status.loaded,
        devise: result.getSuccess()?.devises,
        date: result.getSuccess()?.date,
        source: result.getSuccess()?.source,
      ));
    } else {
      emit(state.copyWith(
          status: Status.error, error: result.getError()?.message));
    }
  }
}
