class AppException implements Exception {
  final String message;

  const AppException({this.message = ""});
}

class NoConnectionException extends AppException {}

class PageNotFoundException extends AppException {
  const PageNotFoundException({
    super.message,
  });
}

class ServerException extends AppException {
  const ServerException({
    super.message,
  });
}

/// User Exceptions
///
/// Exception par défaut pour les opérations utilisateur.
class UserException extends AppException {}

/// Register
class UserRegisterException extends AppException {
  const UserRegisterException({
    super.message,
  });
}

/// Login
class UserLoginException extends AppException {}

class UserLoginUserNotFoundException extends AppException {}

class UserLoginPasswordException extends AppException {}
