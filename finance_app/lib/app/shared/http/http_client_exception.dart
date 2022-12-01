class HttpClientException implements Exception {
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
}
