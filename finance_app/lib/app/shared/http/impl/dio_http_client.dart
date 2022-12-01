import 'package:dio/dio.dart';
import 'package:finance_app/app/shared/http/http_client.dart';
import 'package:finance_app/app/shared/http/http_client_exception.dart';

class DioHttpClient implements HttpClient {
  final Dio _client;

  DioHttpClient(this._client) {
    _client.interceptors.add(
      InterceptorsWrapper(
        onError: (DioError e, handler) {
          e.error = HttpClientException(
            httpStatusErrorMessage: e.message,
            response: e.response,
          );

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

  // TODO - explain it
  HttpClientException _handleDioError(DioError e) {
    var error = e.error;
    if (error is HttpClientException) return error;
    throw e;
  }
}
