import 'package:MIPS/common/error/failures.dart';
import 'package:MIPS/common/result/results.dart';
import 'package:MIPS/domain/contracts/exchange_rate_repository.dart';
import 'package:MIPS/domain/entities/exchange_rate.dart';

class GetExchangeRateUsecase {
  final ExchangeRateRepository exchangeRateRepository;

  const GetExchangeRateUsecase({
    required this.exchangeRateRepository,
  });

  Future<Result<Failure, ExchangeRate>> call() async {
    return exchangeRateRepository.getExchangeRate();
  }
}
