import 'package:finance_app/app/shared/app_exception/app_exception.dart';

extension StringListExtension on Iterable<String> {
  double getHighestDoubleValue() {
    _doubleListValidation();

    var highestItemsValue = reduce((value, element) =>
        double.parse(value) > double.parse(element) ? value : element);

    return double.parse(highestItemsValue);
  }

  double getLowestDoubleValue() {
    _doubleListValidation();

    var lowestItemsValue = reduce((value, element) =>
        double.parse(value) < double.parse(element) ? value : element);

    return double.parse(lowestItemsValue);
  }

  void _doubleListValidation() {
    if (any((element) => element is double == false)) {
      throw StringListExtensionException(
        'List should contain only decimal values',
      );
    }
  }
}

class StringListExtensionException implements AppException {
  final String _message;

  StringListExtensionException(this._message);

  @override
  String errorMessage() => _message;
}
