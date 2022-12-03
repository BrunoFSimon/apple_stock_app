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
        currentValue: _resolveValue(e, itemsMap),
        dayBeforeValue: _getPreviousValue(e, itemsMap),
      ),
    );

    var lastItemCurrentValue = items.last.currentValue;

    if (lastItemCurrentValue == null) {
      throw FinanceChartRepositoryException('lastItemCurrentValue is null');
    }

    var result = GetFinanceChartResult(
      currencyCode: data.meta.currency,
      symbol: data.meta.symbol,
      items: items.toList(),
      currentValue: data.meta.regularMarketPrice,
      dayBeforeValue: lastItemCurrentValue,
    );

    return result;
  }

  /// It takes the first value found before the current value
  /// in cases when the current value is null
  double? _resolveValue(
      MapEntry<int, double?> mapEntry, Map<int, double?> itemsMap) {
    var value = mapEntry.value;

    if (value != null) return value;

    return _getPreviousValue(mapEntry, itemsMap);
  }

  /// [_resolveValue]'s helper function
  double? _getPreviousValue(
      MapEntry<int, double?> item, Map<int, double?> itemsMap) {
    var entries = itemsMap.entries.toList();

    var currentItemList = entries.where(
        (element) => element.key == item.key && element.value == item.value);

    if (currentItemList.isEmpty) return null;

    var currentIndex = entries.indexOf(currentItemList.first);
    if (currentIndex == 0) return null;

    var previousIndex = currentIndex - 1;
    var previsousItem = entries[previousIndex];

    var previsousItemValue = previsousItem.value;

    if (previsousItemValue != null) return previsousItemValue;

    return _getPreviousValue(previsousItem, itemsMap);
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
