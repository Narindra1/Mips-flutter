import 'package:mips/common/common.dart';
import 'package:mips/domain/entities/devise.dart';

abstract class DeviseRepository {
  Future<Result<Failure, List<Devise>>> getDeviseList();
}
