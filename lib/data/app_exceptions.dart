class AppExceptions implements Exception {
  final _message;
  final _prefix;

  AppExceptions([this._message, this._prefix]);

  String toString() {
    return '$_prefix$_message';
  }
}

class InternetException extends AppExceptions {
  InternetException([String? msg]) : super(msg, 'No internet connection.');
}

class RequestTimeoutException extends AppExceptions {
  RequestTimeoutException([String? msg]) : super(msg, 'Connection timeout.');
}

class ServerException extends AppExceptions {
  ServerException([String? msg]) : super(msg, 'Invalid server response.');
}

class FetchDataException extends AppExceptions {
  FetchDataException([String? msg]) : super(msg, 'Error during communication.');
}

class BadRequestException extends AppExceptions {
  BadRequestException([String? msg]) : super(msg, 'Invalid request.');
}

class InvalidInputException extends AppExceptions {
  InvalidInputException([String? msg]) : super(msg, 'Invalid input.');
}



