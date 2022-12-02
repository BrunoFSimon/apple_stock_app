extension DoubleList on Iterable<double> {
  double getHighestDoubleValue() {
    var highestItemsValue =
        reduce((value, element) => value > element ? value : element);

    return highestItemsValue;
  }
}

extension DoubleAsStringList on Iterable<String> {
  double getHighestDoubleValue() {
    var highestItemsValue = reduce((value, element) =>
        double.parse(value) > double.parse(element) ? value : element);

    return double.parse(highestItemsValue);
  }

  double getLowestValue() {
    var lowestItemsValue = reduce((value, element) =>
        double.parse(value) < double.parse(element) ? value : element);

    return double.parse(lowestItemsValue);
  }
}
