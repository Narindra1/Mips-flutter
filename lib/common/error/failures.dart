import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure({this.message = ""});

  @override
  List<Object> get props => [message];
}

class NoConnectionFailure extends Failure {}

class ItemNotFoundFailure extends Failure {}

class ServerFailure extends Failure {
  const ServerFailure({
    super.message,
  });
}

class PageNotFoundFailure extends Failure {}

class UserRegisterFailure extends Failure {
  const UserRegisterFailure({
    super.message,
  });
}

class NoAvailableAppUpdateFailure extends Failure {}
