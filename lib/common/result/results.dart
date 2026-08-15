import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

// Class to handle result
// [E] error,
// [S] success
@sealed
abstract class Result<E, S> {
  //return the value of [E]
  E? getError();

  //return the value of [S]
  S? getSuccess();

  // return true if current result is success

  bool isError();

  bool isSuccess();

  //return true is current result is error
  // Function to proccess result and return [W]
  // whenError procceed an error and return result
  // whenError whenSuccess a success and return result
  W when<W>(W Function(E error) whenError, W Function(S success) whenSuccess);
}

// For a Success Result
class Success<E, S> extends Equatable implements Result<E, S> {
  final S _success;

  const Success(this._success);

  @override
  bool isError() {
    return false;
  }

  @override
  bool isSuccess() {
    return true;
  }

  @override
  E? getError() {
    return null;
  }

  @override
  S? getSuccess() {
    return _success;
  }

  @override
  W when<W>(W Function(E error) whenError, W Function(S success) whenSuccess) {
    return whenSuccess(_success);
  }

  @override
  List<S> get props => [_success];

  @override
  bool? get stringify => false;
}

// For a Success Result
class Error<E, S> extends Equatable implements Result<E, S> {
  final E _error;

  const Error(this._error);

  @override
  bool isError() {
    return true;
  }

  @override
  bool isSuccess() {
    return false;
  }

  @override
  E? getError() {
    return _error;
  }

  @override
  S? getSuccess() {
    return null;
  }

  @override
  W when<W>(W Function(E error) whenError, W Function(S success) whenSuccess) {
    return whenError(_error);
  }

  @override
  List<E> get props => [_error];

  @override
  bool? get stringify => false;
}

// Default success result,
// if dont return [S]
// instead returning  Result<E,void>
// return Result<E, SuccessResult>
class SuccessResult {
  const SuccessResult();
}
