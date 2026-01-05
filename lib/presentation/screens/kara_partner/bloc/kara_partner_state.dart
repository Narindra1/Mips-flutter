part of 'kara_partner_bloc.dart';

enum KaraProvinceStatus { loading, loaded, error }

enum KaraSubscriptionStatus { sending, sent, notSending, error }

final class KaraPartnerState extends Equatable {
  const KaraPartnerState({
    required this.provinces,
    required this.karaProvinceStatus,
    required this.karaSubscriptionStatus,
    required this.error,
  });
  final List<Province> provinces;
  final KaraProvinceStatus karaProvinceStatus;
  final KaraSubscriptionStatus karaSubscriptionStatus;
  final String error;

  KaraPartnerState copyWith({
    List<Province>? provinces,
    KaraProvinceStatus? karaProvinceStatus,
    KaraSubscriptionStatus? karaSubscriptionStatus,
    String? error,
  }) {
    return KaraPartnerState(
      provinces: provinces ?? this.provinces,
      karaProvinceStatus: karaProvinceStatus ?? this.karaProvinceStatus,
      karaSubscriptionStatus:
          karaSubscriptionStatus ?? this.karaSubscriptionStatus,
      error: error ?? this.error,
    );
  }

  @override
  List<Object> get props => [
        provinces,
        karaProvinceStatus,
        karaSubscriptionStatus,
        error,
      ];
}
