import 'package:flutter/foundation.dart';
import 'package:mips/common/common.dart';

import 'package:mips/domain/domain.dart';
import 'package:mips/data/data.dart';

/// Implémentation du dépôt pour la gestion des menus.
///
/// Ce service utilise une source de données distante ([RemoteDataSource])
/// pour effectuer des opérations liées aux menus, telles que :
/// - aimer ou ne pas aimer un menu,
/// - récupérer un menu par son identifiant,
/// - obtenir la liste des menus parents ,
/// - récupérer les options tarifaires disponibles pour un menu .
///
class MenuRepositoryImpl implements MenuRepository {
  final RemoteDataSource remoteDataSource;

  MenuRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Result<Failure, Menu>> likeMenu(String id, bool isLike) async {
    try {
      Menu result = (await (remoteDataSource.likeMenu(id, isLike))).toEntity();
      return Success(result);
    } on AppException catch (e) {
      AppUtils.showDebugLog(runtimeType, e.toString());
      if (e is NoConnectionException) {
        return Error(NoConnectionFailure());
      }
      return Error(ServerFailure(message: e.message));
    } on Exception catch (e) {
      return Error(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Result<Failure, Menu>> getMenuById(String id) async {
    try {
      Menu result = (await (remoteDataSource.fetchMenu(id))).toEntity();
      if (kDebugMode) {
        print("MENU $id");
      }
      return Success(result);
    } on AppException catch (e) {
      AppUtils.showDebugLog(runtimeType, e.toString());
      if (e is NoConnectionException) {
        return Error(NoConnectionFailure());
      }
      return Error(ServerFailure(message: e.message));
    } on Exception catch (e) {
      return Error(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Result<Failure, List<Menu>>> getMenuParents(String id) async {
    try {
      List<Menu> result = (await (remoteDataSource.getParentMenu(
        id,
      ))).map((e) => e.toEntity()).toList();
      return Success(result);
    } on AppException catch (e) {
      AppUtils.showDebugLog(runtimeType, e.toString());
      if (e is NoConnectionException) {
        return Error(NoConnectionFailure());
      }
      return Error(ServerFailure(message: e.message));
    } on Exception catch (e) {
      return Error(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Result<Failure, List<AnnonceTarifOption>>> getMenuAvaliability(
    String id,
  ) async {
    try {
      List<AnnonceTarifOption> result =
          (await (remoteDataSource.getMenuTarifWithOption(
            id,
          ))).map((e) => e.toEntity()).toList();
      return Success(result);
    } on AppException catch (e) {
      AppUtils.showDebugLog(runtimeType, e.toString());
      if (e is NoConnectionException) {
        return Error(NoConnectionFailure());
      }
      return Error(ServerFailure(message: e.message));
    } on Exception catch (e) {
      return Error(ServerFailure(message: e.toString()));
    }
  }
}
