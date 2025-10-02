import 'package:get/get.dart';

class AppExceptions implements Exception {
  final _message;
  final _prefix;

  AppExceptions([this._message, this._prefix]);

  String toString() {
    return '$_prefix$_message';
  }
}

class InternetException extends AppExceptions {
  InternetException([String? msg]) : super(msg, 'internet_error'.tr);
}

class RequestTimeoutException extends AppExceptions {
  RequestTimeoutException([String? msg]) : super(msg, 'timeout_error'.tr);
}

class ServerException extends AppExceptions {
  ServerException([String? msg]) : super(msg, 'server_error'.tr);
}

class FetchDataException extends AppExceptions {
  FetchDataException([String? msg]) : super(msg, 'fetch_error'.tr);
}

class BadRequestException extends AppExceptions {
  BadRequestException([String? msg]) : super(msg, 'bad_request'.tr);
}

class InvalidInputException extends AppExceptions {
  InvalidInputException([String? msg]) : super(msg, 'invalid_input'.tr);
}



