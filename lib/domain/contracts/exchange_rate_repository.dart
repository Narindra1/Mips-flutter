import 'package:MIPS/common/common.dart';
import 'package:MIPS/domain/entities/exchange_rate.dart';

abstract class ExchangeRateRepository {
  Future<Result<Failure, ExchangeRate>> getExchangeRate();
}
