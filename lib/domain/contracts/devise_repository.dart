import 'package:MIPS/common/common.dart';
import 'package:MIPS/domain/entities/devise.dart';

abstract class DeviseRepository {
  Future<Result<Failure, List<Devise>>> getDeviseList();
}
