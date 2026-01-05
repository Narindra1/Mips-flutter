import 'package:MIPS/domain/entities/province.dart';
import 'package:MIPS/domain/usecases/kara_partner/get_kara_province_list_usecase.dart';
import 'package:MIPS/domain/usecases/kara_partner/kara_subscription_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'kara_partner_event.dart';
part 'kara_partner_state.dart';

class KaraPartnerBloc extends Bloc<KaraPartnerEvent, KaraPartnerState> {
  KaraPartnerBloc({
    required this.getKaraProvinceListUsecase,
    required this.karaSubscriptionUsecase,
  }) : super(KaraPartnerState(
            provinces: [],
            karaProvinceStatus: KaraProvinceStatus.loading,
            karaSubscriptionStatus: KaraSubscriptionStatus.notSending,
            error: "")) {
    on<KaraProvinceLoaded>(_onKaraProvinceLoaded);
    on<KaraSubscriptionLoaded>(_onKaraSubscriptionLoaded);
  }
  final GetKaraProvinceListUsecase getKaraProvinceListUsecase;
  final KaraSubscriptionUsecase karaSubscriptionUsecase;

  void _onKaraProvinceLoaded(KaraProvinceLoaded event, Emitter emit) async {
    emit(state.copyWith(karaProvinceStatus: KaraProvinceStatus.loading));
    var result = await getKaraProvinceListUsecase();
    if (result.isSuccess()) {
      emit(state.copyWith(
        karaProvinceStatus: KaraProvinceStatus.loaded,
        provinces: result.getSuccess(),
      ));
    } else {
      emit(state.copyWith(
          karaProvinceStatus: KaraProvinceStatus.error,
          error: result.getError()?.message));
    }
  }

  void _onKaraSubscriptionLoaded(
      KaraSubscriptionLoaded event, Emitter emit) async {
    emit(state.copyWith(
        karaSubscriptionStatus: KaraSubscriptionStatus.notSending));
    var result = await karaSubscriptionUsecase();
    print("RESULT BLOC : ${result.isSuccess()}");
    if (result.isSuccess()) {
      emit(state.copyWith(
          karaSubscriptionStatus: KaraSubscriptionStatus.sending));
      await Future.delayed(Duration(seconds: 1), () {
        emit(state.copyWith(
            karaSubscriptionStatus: KaraSubscriptionStatus.sent));
      });
    } else {
      emit(state.copyWith(
          karaSubscriptionStatus: KaraSubscriptionStatus.error,
          error: result.getError()?.message));
    }
  }
}
