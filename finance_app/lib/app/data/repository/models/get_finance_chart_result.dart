class GetFinanceChartResult {
  final String currencyCode;
  final String symbol;
  final Iterable<GetFinanceChartResultItem> items;
  final String currentValue;
  final String variation;

  GetFinanceChartResult({
    required this.currencyCode,
    required this.symbol,
    required this.items,
    required this.currentValue,
    required this.variation,
  });
}

class GetFinanceChartResultItem {
  final DateTime date;
  final String value;

  GetFinanceChartResultItem({
    required this.date,
    required this.value,
  });
}
