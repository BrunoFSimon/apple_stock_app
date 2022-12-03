extension DoubleExtension on double {
  String toCurrencyString({String? currencyCode}) {
    if (currencyCode == null) return toStringAsFixed(2);

    return '$currencyCode ${toStringAsFixed(2)}';
  }
}
