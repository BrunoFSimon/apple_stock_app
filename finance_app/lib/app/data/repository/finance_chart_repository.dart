import 'package:finance_app/app/data/provider/finance_chart_provider.dart';
import 'package:finance_app/app/data/repository/models/get_finance_chart_result.dart';
import 'package:finance_app/app/shared/app_exception/app_exception.dart';

abstract class FinanceChartRepository {
  Future<GetFinanceChartResult> getFinanceChart(String symbol);
}

class FinanceChartRepositoryImpl implements FinanceChartRepository {
  final FinanceChartProvider _provider;

  FinanceChartRepositoryImpl(this._provider);

  @override
  Future<GetFinanceChartResult> getFinanceChart(String symbol) async {
    var response = await _provider.getFinanceChart(symbol);

    var data = response.chart.result?.first;

    if (data == null) {
      throw FinanceChartRepositoryException('Chart Result is null');
    }

    var timestampList = data.timestamp;
    var openList = data.indicators.quote.first.open;

    var itemsMap = Map.fromIterables(timestampList, openList);

    var items = itemsMap.entries.map(
      (e) => GetFinanceChartResultItem(
        date: DateTime.fromMillisecondsSinceEpoch(e.key * 1000),
        value: _resolveValue(e, itemsMap),
      ),
    );

    var variation = _resolveVariation(openList, data.meta.regularMarketPrice);

    var result = GetFinanceChartResult(
      currencyCode: data.meta.currency,
      symbol: data.meta.symbol,
      items: items,
      currentValue: data.meta.regularMarketPrice.toStringAsFixed(2),
      variation: variation,
    );

    return result;
  }

  String _resolveVariation(List<double?> openList, double curentValue) {
    var pastValue = openList.lastWhere((element) => element != null);

    if (pastValue == null) {
      throw FinanceChartRepositoryException('Past value is null');
    }

    var variation = (pastValue - curentValue).abs();

    if (variation > 0) return '+${variation.toStringAsFixed(2)}';
    return '-${variation.toStringAsFixed(2)}';
  }

  String _resolveValue(
      MapEntry<int, double?> mapEntry, Map<int, double?> itemsMap) {
    var value = mapEntry.value;

    if (value != null) return value.toStringAsFixed(2);

    return _getPreviousValue(mapEntry.key, itemsMap);
  }

  String _getPreviousValue(int key, Map<int, double?> itemsMap) {
    var previousKey = itemsMap.keys.firstWhere((k) => k < key, orElse: () => 0);

    return itemsMap[previousKey]?.toStringAsFixed(2) ??
        _getPreviousValue(previousKey, itemsMap);
  }
}

class FinanceChartRepositoryException implements AppException {
  final String _message;

  FinanceChartRepositoryException(this._message);

  @override
  String errorMessage() {
    return _message;
  }
}
