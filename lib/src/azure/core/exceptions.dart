import 'dart:core';

class ArgumentException implements Exception {
  String cause;
  String argumentName;

  ArgumentException(this.cause, [this.argumentName = ""]);
  @override
  String toString() {
    return "ArgumentException";
  }
}

class ArgumentOutOfRangeException implements Exception {
  String cause;
  String argumentName;

  ArgumentOutOfRangeException(this.cause, [this.argumentName = ""]);

  @override
  String toString() {
    return "ArgumentOutOfRangeException";
  }
}

class ArgumentNullException implements Exception {
  String cause;
  String argumentName;

  ArgumentNullException(this.cause, [this.argumentName = ""]);

  @override
  String toString() {
    return "ArgumentNullException";
  }
}

class RequestFailedException implements Exception {
  String cause;
  String argumentName;
  final int _status = 0;

  int get status => _status;

  RequestFailedException(this.cause, [this.argumentName = ""]);

  @override
  String toString() {
    return "RequestFailedException";
  }
}
