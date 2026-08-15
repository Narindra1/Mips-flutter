import 'package:mips/common/error/failures.dart';
import 'package:mips/common/result/results.dart';
import 'package:mips/domain/contracts/exchange_rate_repository.dart';
import 'package:mips/domain/entities/exchange_rate.dart';

class GetExchangeRateUsecase {
  final ExchangeRateRepository exchangeRateRepository;

  const GetExchangeRateUsecase({required this.exchangeRateRepository});

  Future<Result<Failure, ExchangeRate>> call() async {
    return exchangeRateRepository.getExchangeRate();
  }
}
