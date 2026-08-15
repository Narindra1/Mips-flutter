import 'package:mips/common/common.dart';
import 'package:mips/domain/entities/exchange_rate.dart';

abstract class ExchangeRateRepository {
  Future<Result<Failure, ExchangeRate>> getExchangeRate();
}
