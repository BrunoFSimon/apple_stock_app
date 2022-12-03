import 'package:dio/dio.dart';
import 'package:finance_app/app/shared/http/http_client.dart';
import 'package:finance_app/app/shared/http/http_client_exception.dart';

class DioHttpClient implements HttpClient {
  final Dio _client;

  DioHttpClient(this._client) {
    _client.interceptors.add(
      InterceptorsWrapper(
        onError: (DioError e, handler) {
          /// Explicação
          /// A instanciação abaixo ficaria melhor no método [_handleException()]
          /// mas para demonstrar o conceito de interceptor deixei aqui
          e.error = HttpClientException(
            httpStatusErrorMessage: e.message,
            response: e.response,
          );

          // TODO - Handle this error that occurs when the internet is turned off
          // SocketException: Failed host lookup: 'query2.finance.yahoo.com' (OS Error: No address associated with hostname, errno = 7)

          handler.next(e);
        },
      ),
    );
  }

  @override
  Future<Map<String, dynamic>> get(
    String url, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      var response = await _client.get(url, queryParameters: queryParameters);
      return response.data;
    } on DioError catch (e) {
      throw _handleDioError(e);
    }
  }

  @override
  Future<Map<String, dynamic>> post(
    String url, {
    Map<String, dynamic>? queryParameters,
    required Map<String, dynamic> data,
  }) async {
    try {
      var response =
          await _client.post(url, queryParameters: queryParameters, data: data);
      return response.data;
    } on DioError catch (e) {
      throw _handleDioError(e);
    }
  }

  /// Explicação
  /// Ao interceptar o erro do Dio, o mesmo é convertido para um [HttpClientException]
  /// através deste ErrorHandler inserido nos métodos get, post, etc.
  /// Para facilitar o tratamento dos erros nas controllers.
  HttpClientException _handleDioError(DioError e) {
    var error = e.error;
    if (error is HttpClientException) return error;
    throw e;
  }
}
