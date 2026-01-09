import 'package:MIPS/common/common.dart';
import 'package:MIPS/data/data.dart';
import 'package:MIPS/domain/domain.dart';

/// Implémentation du dépôt pour la gestion des utilisateurs.
///
/// Utilise une source de données distante ([RemoteDataSource]) pour effectuer
/// toutes les opérations liées au compte utilisateur, telles que :
/// Authentification,Enregistrement et mise à jour de profil,...
class UserRepositoryImpl implements UserRepository {
  final RemoteDataSource remoteDataSource;

  @override
  Future<Result<Failure, User>> getUserInfo() async {
    try {
      User result = (await remoteDataSource.fetchUserInfo()).toEntity();
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
  Future<Result<Failure, User>> loginUser(
      String login, String password, bool stayLogged) async {
    try {
      User result =
          (await remoteDataSource.loginUser(login, password, stayLogged))
              .toEntity();
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
  Future<Result<Failure, User>> registerUser(User user) async {
    try {
      var result =
          (await remoteDataSource.registerUser(UserModel.fromEntity(user)))
              .toEntity();
      return Success(result);
    } on AppException catch (e) {
      AppUtils.showDebugLog(runtimeType, e.toString());
      if (e is NoConnectionException) {
        return Error(NoConnectionFailure());
      } else if (e is UserRegisterException) {
        return Error(UserRegisterFailure(message: (e.message.toString())));
      }
      return Error(ServerFailure(message: e.message));
    } on Exception catch (e) {
      return Error(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Result<Failure, User>> updateUser(User user) async {
    try {
      User result =
          (await remoteDataSource.updateUser(UserModel.fromEntity(user)))
              .toEntity();
      return Success(result);
    } on AppException catch (e) {
      AppUtils.showDebugLog(runtimeType, e.toString());
      if (e is NoConnectionException) {
        return Error(NoConnectionFailure());
      } else if (e is UserRegisterException) {
        return Error(UserRegisterFailure(message: (e.message.toString())));
      }
      return Error(ServerFailure(message: e.message));
    } on Exception catch (e) {
      return Error(ServerFailure(message: e.toString()));
    }
  }

  const UserRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Result<Failure, SuccessResult>> deleteUser() async {
    try {
      await remoteDataSource.deleteUser();
      return const Success(SuccessResult());
    } on AppException catch (e) {
      AppUtils.showDebugLog(runtimeType, e.toString());
      if (e is NoConnectionException) {
        return Error(NoConnectionFailure());
      } else if (e is UserRegisterException) {
        return Error(UserRegisterFailure(message: (e.message.toString())));
      }
      return Error(ServerFailure(message: e.message));
    } on Exception catch (e) {
      return Error(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Result<Failure, UserMenuProfil>> getUserMenuProfil() async {
    try {
      var result = (await remoteDataSource.getUserMenuProfil()).toEntity();
      return Success(result);
    } on AppException catch (e) {
      AppUtils.showDebugLog(runtimeType, e.toString());
      if (e is NoConnectionException) {
        return Error(NoConnectionFailure());
      } else if (e is UserRegisterException) {
        return Error(UserRegisterFailure(message: (e.message.toString())));
      }
      return Error(ServerFailure(message: e.message));
    } on Exception catch (e) {
      return Error(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Result<Failure, SuccessResult>> logoutUser() async {
    try {
      await remoteDataSource.logoutUser();
      return const Success(SuccessResult());
    } on AppException catch (e) {
      AppUtils.showDebugLog(runtimeType, e.toString());
      if (e is UserLoginException) {
        return const Success(SuccessResult());
      } else if (e is NoConnectionException) {
        return Error(NoConnectionFailure());
      } else if (e is UserRegisterException) {
        return Error(UserRegisterFailure(message: (e.message.toString())));
      }
      return Error(ServerFailure(message: e.message));
    } on Exception catch (e) {
      return Error(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Result<Failure, SuccessResult>> forgotPassword(String email) async {
    try {
      await remoteDataSource.forgotPassword(email);
      return const Success(SuccessResult());
    } on AppException catch (e) {
      AppUtils.showDebugLog(runtimeType, e.toString());
      if (e is NoConnectionException) {
        return Error(NoConnectionFailure());
      } else if (e is UserRegisterException) {
        return Error(UserRegisterFailure(message: (e.message.toString())));
      }
      return Error(ServerFailure(message: e.message));
    } on Exception catch (e) {
      return Error(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Result<Failure, User>> resetPassword(
      String validationCode, String password) async {
    try {
      var result =
          (await remoteDataSource.resetPassword(validationCode, password))
              .toEntity();
      return Success(result);
    } on AppException catch (e) {
      AppUtils.showDebugLog(runtimeType, e.toString());
      if (e is NoConnectionException) {
        return Error(NoConnectionFailure());
      } else if (e is UserRegisterException) {
        return Error(UserRegisterFailure(message: (e.message.toString())));
      }
      return Error(ServerFailure(message: e.message));
    } on Exception catch (e) {
      return Error(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Result<Failure, User>> transfertFaka(
      String phoneReceiver, int amount, String motif) async {
    try {
      var result =
          (await remoteDataSource.transfertFaka(phoneReceiver, amount, motif))
              .toEntity();
      return Success(result);
    } on AppException catch (e) {
      AppUtils.showDebugLog(runtimeType, e.toString());
      if (e is NoConnectionException) {
        return Error(NoConnectionFailure());
      } else if (e is UserRegisterException) {
        return Error(UserRegisterFailure(message: (e.message.toString())));
      }
      return Error(ServerFailure(message: e.message));
    } on Exception catch (e) {
      return Error(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Result<Failure, SuccessResult>> checkPassword(String password) async {
    try {
      (await remoteDataSource.checkPassword(password));
      return const Success(SuccessResult());
    } on AppException catch (e) {
      AppUtils.showDebugLog(runtimeType, e.toString());
      if (e is NoConnectionException) {
        return Error(NoConnectionFailure());
      } else if (e is UserRegisterException) {
        return Error(UserRegisterFailure(message: (e.message.toString())));
      }
      return Error(ServerFailure(message: e.message));
    } on Exception catch (e) {
      return Error(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Result<Failure, User>> changePassword(
      String oldPassword, String newPassword) async {
    try {
      var result =
          (await remoteDataSource.changePassword(oldPassword, newPassword))
              .toEntity();
      return Success(result);
    } on AppException catch (e) {
      AppUtils.showDebugLog(runtimeType, e.toString());
      if (e is NoConnectionException) {
        return Error(NoConnectionFailure());
      } else if (e is UserRegisterException) {
        return Error(UserRegisterFailure(message: (e.message.toString())));
      }
      return Error(ServerFailure(message: e.message));
    } on Exception catch (e) {
      return Error(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Result<Failure, List<Message>>> getUserMessages(int page) async {
    try {
      var result = (await remoteDataSource.fetchUserMessage(page))
          .map(
            (e) => e.toEntity(),
          )
          .toList();

      return Success(result);
    } on AppException catch (e) {
      AppUtils.showDebugLog(runtimeType, e.toString());
      if (e is NoConnectionException) {
        return Error(NoConnectionFailure());
      } else if (e is UserRegisterException) {
        return Error(UserRegisterFailure(message: (e.message.toString())));
      }
      return Error(ServerFailure(message: e.message));
    } on Exception catch (e) {
      return Error(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Result<Failure, SuccessResult>> viewUserMessage(int messageId) async {
    try {
      (await remoteDataSource.viewUserMessage(messageId));

      return const Success(SuccessResult());
    } on AppException catch (e) {
      AppUtils.showDebugLog(runtimeType, e.toString());
      if (e is NoConnectionException) {
        return Error(NoConnectionFailure());
      } else if (e is UserRegisterException) {
        return Error(UserRegisterFailure(message: (e.message.toString())));
      }
      return Error(ServerFailure(message: e.message));
    } on Exception catch (e) {
      return Error(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Result<Failure, SuccessResult>> viewAllUserMessage() async {
    try {
      (await remoteDataSource.viewAllUserMessage());

      return const Success(SuccessResult());
    } on AppException catch (e) {
      AppUtils.showDebugLog(runtimeType, e.toString());
      if (e is NoConnectionException) {
        return Error(NoConnectionFailure());
      } else if (e is UserRegisterException) {
        return Error(UserRegisterFailure(message: (e.message.toString())));
      }
      return Error(ServerFailure(message: e.message));
    } on Exception catch (e) {
      return Error(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Result<Failure, List<TransactionHistory>>> getTransactionHistory(
      int page) async {
    try {
      var result = (await remoteDataSource.fetchUserTransactionHistory(page))
          .map(
            (e) => e.toEntity(),
          )
          .toList();

      return Success(result);
    } on AppException catch (e) {
      AppUtils.showDebugLog(runtimeType, e.toString());
      if (e is NoConnectionException) {
        return Error(NoConnectionFailure());
      } else if (e is UserRegisterException) {
        return Error(UserRegisterFailure(message: (e.message.toString())));
      }
      return Error(ServerFailure(message: e.message));
    } on Exception catch (e) {
      return Error(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Result<Failure, int>> getUserUnreadMessageCount() async {
    try {
      var result = (await remoteDataSource.getUserUnreadMessageCount());

      return Success(result);
    } on AppException catch (e) {
      AppUtils.showDebugLog(runtimeType, e.toString());
      if (e is NoConnectionException) {
        return Error(NoConnectionFailure());
      } else if (e is UserRegisterException) {
        return Error(UserRegisterFailure(message: (e.message.toString())));
      }
      return Error(ServerFailure(message: e.message));
    } on Exception catch (e) {
      return Error(ServerFailure(message: e.toString()));
    }
  }
}
