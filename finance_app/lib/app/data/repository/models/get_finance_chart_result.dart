/// Explicação
/// Como a classe [GetFinanceChartResponse] é bastante complexa e possui
/// muitos dados que não são utilizados na aplicação, criei a classe [GetFinanceChartResult]
/// para que a mesma contenha apenas os dados que serão utilizados na aplicação de maneira
/// mais organizada e com os dados já formatados prontos para utilização na controller.
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
