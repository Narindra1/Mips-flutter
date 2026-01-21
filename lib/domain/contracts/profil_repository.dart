import 'package:MIPS/common/common.dart';
import 'package:MIPS/domain/entities/annonce.dart';
import 'package:MIPS/domain/entities/user.dart';

abstract class ProfilRepository {
  Future<Result<Failure, User>> getUserInfoProfilById(int id);
  Future<Result<Failure, int>> getUserProfilAnnoncesCount(int id);
  Future<Result<Failure, List<Annonce>>> getAnnoncesUserProfilById(
      int id, int page, String query);
}
