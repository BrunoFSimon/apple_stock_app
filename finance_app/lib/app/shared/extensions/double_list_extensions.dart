extension DoubleList on Iterable<double> {
  double getHighestDoubleValue() {
    var highestItemsValue =
        reduce((value, element) => value > element ? value : element);

    return highestItemsValue;
  }
}
