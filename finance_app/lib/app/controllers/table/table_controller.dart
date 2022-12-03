import 'package:finance_app/app/controllers/table/table_arguments.dart';
import 'package:finance_app/app/data/repository/finance_chart_repository.dart';
import 'package:finance_app/app/data/repository/models/get_finance_chart_result.dart';
import 'package:finance_app/app/shared/app_exception/app_exception.dart';
import 'package:get/get.dart';

class TableController extends GetxController
    with StateMixin<GetFinanceChartResult> {
  final FinanceChartRepository repository;
  final TableArguments arguments;

  TableController({
    required this.repository,
    required this.arguments,
  });

  @override
  void onInit() {
    change(null, status: RxStatus.loading());
    _fetch(arguments.symbol);
    super.onInit();
  }

  Future<void> _fetch(String symbol) async {
    try {
      var response = await repository.getFinanceChart(symbol);
      change(response, status: RxStatus.success());
    } on AppException catch (e) {
      change(null, status: RxStatus.error(e.errorMessage()));
    }
  }

  void retry() {
    change(null, status: RxStatus.loading());
    _fetch(arguments.symbol);
  }
}
