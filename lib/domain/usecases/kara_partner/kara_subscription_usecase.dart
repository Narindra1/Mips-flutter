import 'package:MIPS/domain/contracts/kara_partner_repository.dart';

import '../../../common/common.dart';

class KaraSubscriptionUsecase {
  final KaraPartnerRepository karaPartnerRepository;

  const KaraSubscriptionUsecase({
    required this.karaPartnerRepository,
  });

  Future<Result<Failure, SuccessResult>> call() async {
    return karaPartnerRepository.karaSubscription();
  }
}
