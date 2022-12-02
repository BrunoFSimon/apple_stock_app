import 'package:finance_app/app/data/provider/responses/get_finance_chart_response.dart';
import 'package:finance_app/app/shared/http/http_client.dart';
import 'package:finance_app/app/shared/http/http_client_exception.dart';

abstract class FinanceChartProvider {
  Future<GetFinanceChartModel> getFinanceChart(String symbol);
}

class FinanceChartProviderImpl implements FinanceChartProvider {
  final HttpClient _client;

  FinanceChartProviderImpl(this._client);

  @override
  Future<GetFinanceChartModel> getFinanceChart(String symbol) async {
    try {
      var url =
          'https://query2.finance.yahoo.com/v8/finance/chart/$symbol?metrics=open?&interval=1d&range=30d';

      var response = await _client.get(url);

      return GetFinanceChartModel.fromMap(response);
    } on HttpClientException catch (e) {
      var data = e.response?.data;

      if (data == null) rethrow;

      var getFinanceChartModel = GetFinanceChartModel.fromMap(data);

      var error = getFinanceChartModel.chart.error;

      if (error == null) rethrow;

      throw FinanceChartProviderException(
        code: error.code,
        description: error.description,
        httpClientException: e,
      );
    }
  }
}

class FinanceChartProviderException extends HttpClientException {
  final String code;
  final String description;

  FinanceChartProviderException({
    required this.code,
    required this.description,
    required HttpClientException httpClientException,
  }) : super(
          response: httpClientException.response,
          httpStatusErrorMessage: httpClientException.httpStatusErrorMessage,
        );
}
