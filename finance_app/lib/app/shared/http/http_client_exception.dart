import 'package:finance_app/app/shared/app_exception/app_exception.dart';

class HttpClientException implements AppException {
  final dynamic response;
  final String httpStatusErrorMessage;

  HttpClientException({
    required this.response,
    required this.httpStatusErrorMessage,
  });

  @override
  String toString() {
    return httpStatusErrorMessage;
  }

  @override
  String errorMessage() {
    return httpStatusErrorMessage;
  }
}
