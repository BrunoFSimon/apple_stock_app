abstract class HttpClient {
  Future<Map<String, dynamic>> get(
    String url, {
    Map<String, dynamic> queryParameters,
  });

  Future<Map<String, dynamic>> post(
    String url, {
    Map<String, dynamic> queryParameters,
    required Map<String, dynamic> data,
  });
}
