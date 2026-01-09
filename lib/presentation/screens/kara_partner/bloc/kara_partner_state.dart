part of 'kara_partner_bloc.dart';

enum KaraProvinceStatus { loading, loaded, error }

enum KaraListStatus { loading, loaded, error }

enum KaraSubscriptionStatus { sending, sent, notSending, error }

final class KaraPartnerState extends Equatable {
  const KaraPartnerState({
    required this.provinces,
    required this.karaAnnonces,
    required this.karaListStatus,
    required this.karaProvinceStatus,
    required this.karaSubscriptionStatus,
    required this.isNextListAvailable,
    required this.query,
    required this.error,
  });
  final List<Province> provinces;
  final List<Annonce> karaAnnonces;
  final KaraListStatus karaListStatus;
  final KaraProvinceStatus karaProvinceStatus;
  final KaraSubscriptionStatus karaSubscriptionStatus;
  final bool isNextListAvailable;
  final String query;
  final String error;

  KaraPartnerState copyWith({
    List<Province>? provinces,
    List<Annonce>? karaAnnonces,
    KaraListStatus? karaListStatus,
    KaraProvinceStatus? karaProvinceStatus,
    KaraSubscriptionStatus? karaSubscriptionStatus,
    bool? isNextListAvailable,
    String? query,
    String? error,
  }) {
    return KaraPartnerState(
      provinces: provinces ?? this.provinces,
      karaAnnonces: karaAnnonces ?? this.karaAnnonces,
      karaListStatus: karaListStatus ?? this.karaListStatus,
      karaProvinceStatus: karaProvinceStatus ?? this.karaProvinceStatus,
      karaSubscriptionStatus:
          karaSubscriptionStatus ?? this.karaSubscriptionStatus,
      isNextListAvailable: isNextListAvailable ?? this.isNextListAvailable,
      query: query ?? this.query,
      error: error ?? this.error,
    );
  }

  @override
  List<Object> get props => [
        provinces,
        karaAnnonces,
        karaListStatus,
        karaProvinceStatus,
        karaSubscriptionStatus,
        isNextListAvailable,
        query,
        error,
      ];
}
