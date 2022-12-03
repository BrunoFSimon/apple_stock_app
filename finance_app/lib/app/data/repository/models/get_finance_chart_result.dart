import 'package:finance_app/app/shared/extensions/date_time_extension.dart';
import 'package:finance_app/app/shared/extensions/double_extension.dart';

/// Explicação
/// Como a classe [GetFinanceChartResponse] é bastante complexa e possui
/// muitos dados que não são utilizados na aplicação, criei a classe [GetFinanceChartResult]
/// para que a mesma contenha apenas os dados que serão utilizados na aplicação de maneira
/// mais organizada e com os dados já formatados prontos para utilização na controller.
class GetFinanceChartResult {
  final String currencyCode;
  final String symbol;
  final List<GetFinanceChartResultItem> items;

  final double currentValue;
  final double dayBeforeValue;

  GetFinanceChartResult({
    required this.currencyCode,
    required this.symbol,
    required this.items,
    required this.currentValue,
    required this.dayBeforeValue,
  });

  String get getDayBeforeVariation {
    return _getDayBeforeVariation(currentValue, dayBeforeValue);
  }
}

class GetFinanceChartResultItem {
  final DateTime date;
  final double? currentValue;
  final double? dayBeforeValue;

  GetFinanceChartResultItem({
    required this.date,
    required this.currentValue,
    required this.dayBeforeValue,
  });

  String get dayBeforeFormatedValue {
    var value = dayBeforeValue?.toStringAsFixed(2) ?? '-';

    return value;
  }

  String get getFormatedValue {
    var v = currentValue?.toStringAsFixed(2) ?? '-';

    return v;
  }

  String get getDayBeforeVariation {
    return _getDayBeforeVariation(currentValue, dayBeforeValue);
  }

  String get getDayBeforeVariationPercent {
    return _getPercentVariation(currentValue, dayBeforeValue);
  }

  String get getFormatedDate {
    return date.toFormatedString();
  }

  String variationBeweenCustomValue(double? newValue) {
    return _getPercentVariation(currentValue, newValue);
  }
}

String _getDayBeforeVariation(double? currentValue, double? dayBeforeValue) {
  var currentDay = currentValue;
  var dayBefore = dayBeforeValue;

  if (currentDay == null) return '-';
  if (dayBefore == null) return '-';

  var variation = (currentDay - dayBefore).abs();

  var mathSymbol = variation > 0 ? '+' : '-';

  return '$mathSymbol${variation.toStringAsFixed(2)}';
}

String _getPercentVariation(double? currentValue, double? dayBeforeValue) {
  var currentDay = currentValue;
  var dayBefore = dayBeforeValue;

  if (currentDay == null) return '-';
  if (dayBefore == null) return '-';

  var result = ((dayBefore - currentDay) * 100) / currentDay;

  return '${result.toCurrencyString()}%';
}
