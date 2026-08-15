import 'package:mips/domain/entities/annonce.dart';
import 'package:mips/domain/entities/province.dart';
import 'package:mips/domain/usecases/kara_partner/get_kara_list_by_province_usecase.dart';
import 'package:mips/domain/usecases/kara_partner/get_kara_province_list_usecase.dart';
import 'package:mips/domain/usecases/kara_partner/kara_subscription_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'kara_partner_event.dart';
part 'kara_partner_state.dart';

class KaraPartnerBloc extends Bloc<KaraPartnerEvent, KaraPartnerState> {
  KaraPartnerBloc({
    required this.getKaraProvinceListUsecase,
    required this.karaSubscriptionUsecase,
    required this.getKaraListByProvinceUsecase,
  }) : super(
         KaraPartnerState(
           provinces: [],
           karaAnnonces: [],
           karaListStatus: KaraListStatus.loading,
           karaProvinceStatus: KaraProvinceStatus.loading,
           karaSubscriptionStatus: KaraSubscriptionStatus.notSending,
           isNextListAvailable: false,
           query: "",
           error: "",
         ),
       ) {
    on<KaraProvinceLoaded>(_onKaraProvinceLoaded);
    on<KaraListLoaded>(_onKaraListLoaded);
    on<KaraSubscriptionLoaded>(_onKaraSubscriptionLoaded);
  }
  final GetKaraProvinceListUsecase getKaraProvinceListUsecase;
  final KaraSubscriptionUsecase karaSubscriptionUsecase;
  final GetKaraListByProvinceUsecase getKaraListByProvinceUsecase;

  void _onKaraProvinceLoaded(KaraProvinceLoaded event, Emitter emit) async {
    emit(state.copyWith(karaProvinceStatus: KaraProvinceStatus.loading));
    var result = await getKaraProvinceListUsecase();
    if (result.isSuccess()) {
      emit(
        state.copyWith(
          karaProvinceStatus: KaraProvinceStatus.loaded,
          provinces: result.getSuccess(),
        ),
      );
    } else {
      emit(
        state.copyWith(
          karaProvinceStatus: KaraProvinceStatus.error,
          error: result.getError()?.message,
        ),
      );
    }
  }

  void _onKaraSubscriptionLoaded(
    KaraSubscriptionLoaded event,
    Emitter emit,
  ) async {
    emit(
      state.copyWith(karaSubscriptionStatus: KaraSubscriptionStatus.notSending),
    );
    var result = await karaSubscriptionUsecase(event.provinces, event.slug);
    print("RESULT BLOC : ${result.isSuccess()}");
    if (result.isSuccess()) {
      emit(
        state.copyWith(karaSubscriptionStatus: KaraSubscriptionStatus.sending),
      );
      await Future.delayed(Duration(seconds: 1), () {
        emit(
          state.copyWith(karaSubscriptionStatus: KaraSubscriptionStatus.sent),
        );
      });
    } else {
      if (result.getError()!.message.contains("Data missing")) {
        emit(
          state.copyWith(
            karaSubscriptionStatus: KaraSubscriptionStatus.sending,
          ),
        );
        await Future.delayed(Duration(seconds: 1), () {
          emit(
            state.copyWith(
              karaSubscriptionStatus: KaraSubscriptionStatus.notExist,
              error: result.getError()?.message,
            ),
          );
        });
        emit(
          state.copyWith(
            karaSubscriptionStatus: KaraSubscriptionStatus.notSending,
          ),
        );
      } else if (result.getError()!.message.contains(
        "Payload validation error",
      )) {
        emit(
          state.copyWith(
            karaSubscriptionStatus: KaraSubscriptionStatus.sending,
          ),
        );
        await Future.delayed(Duration(seconds: 1), () {
          emit(
            state.copyWith(
              karaSubscriptionStatus: KaraSubscriptionStatus.pendding,
              error: result.getError()?.message,
            ),
          );
        });
        emit(
          state.copyWith(
            karaSubscriptionStatus: KaraSubscriptionStatus.notSending,
          ),
        );
      } else {
        emit(
          state.copyWith(
            karaSubscriptionStatus: KaraSubscriptionStatus.error,
            error: result.getError()?.message,
          ),
        );
      }
      print("KARA PARTENAIRE ERREUR : ${result.getError()?.message}");
    }
  }

  void _onKaraListLoaded(KaraListLoaded event, Emitter emit) async {
    emit(state.copyWith(karaListStatus: KaraListStatus.loading));
    var result = await getKaraListByProvinceUsecase(
      event.province,
      event.page,
      "",
    );
    if (result.isSuccess()) {
      emit(
        state.copyWith(
          karaAnnonces: result.getSuccess(),
          karaListStatus: KaraListStatus.loaded,
        ),
      );
    } else {
      emit(
        state.copyWith(
          karaListStatus: KaraListStatus.error,
          error: result.getError()?.message,
        ),
      );
    }
  }
}
