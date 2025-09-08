class AppException implements Exception {
  String title;
  String body;

  AppException({required this.title, required this.body});

  @override
  String toString() {
    return "$title: $body";
  }
}

class FetchDataException extends AppException {
  FetchDataException({required String desc})
      : super(title: "FetchDataException", body: desc);
}

class BadRequestException extends AppException {
  BadRequestException({required String desc})
      : super(title: "BadRequestException", body: desc);
}

class UnAuthorizedException extends AppException {
  UnAuthorizedException({required String desc})
      : super(title: "UnAuthorizedException", body: desc);
}

class InvalidInputException extends AppException {
  InvalidInputException({required String desc})
      : super(title: "InvalidInputException", body: desc);
}

class ServerException extends AppException {
  ServerException({required String desc})
      : super(title: "ServerException", body: desc);
}

class NoInternetException extends AppException {
  NoInternetException({required String desc})
      : super(title: "NoInternetException", body: desc);
}