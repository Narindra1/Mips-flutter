part of 'kara_partner_bloc.dart';

sealed class KaraPartnerEvent extends Equatable {
  const KaraPartnerEvent();

  @override
  List<Object> get props => [];
}

class KaraProvinceLoaded extends KaraPartnerEvent {
  const KaraProvinceLoaded();
}

class KaraListLoaded extends KaraPartnerEvent {
  const KaraListLoaded({
    required this.province,
    required this.page,
  });
  final String province;
  final int page;
}

class KaraSubscriptionLoaded extends KaraPartnerEvent {
  const KaraSubscriptionLoaded({
    required this.provinces,
    required this.slug,
  });
  final List<String> provinces;
  final String slug;

  @override
  List<Object> get props => [provinces, slug];
}
