part of 'kara_partner_bloc.dart';

sealed class KaraPartnerEvent extends Equatable {
  const KaraPartnerEvent();

  @override
  List<Object> get props => [];
}

class KaraProvinceLoaded extends KaraPartnerEvent {
  const KaraProvinceLoaded();
}

class KaraSubscriptionLoaded extends KaraPartnerEvent {
  const KaraSubscriptionLoaded();
}
