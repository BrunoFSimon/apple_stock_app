import 'package:finance_app/app/controllers/chart/chart_arguments.dart';
import 'package:finance_app/app/data/repository/finance_chart_repository.dart';
import 'package:finance_app/app/data/repository/models/get_finance_chart_result.dart';
import 'package:finance_app/app/shared/app_exception/app_exception.dart';
import 'package:get/get.dart';

class ChartController extends GetxController
    with StateMixin<GetFinanceChartResult> {
  final FinanceChartRepository repository;
  final ChartArguments arguments;
  final RxBool isRefreshing = false.obs;

  ChartController({
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

  void reload() {
    isRefreshing.value = true;
    _fetch(arguments.symbol).whenComplete(() => isRefreshing.value = false);
  }

  void retry() {
    change(null, status: RxStatus.loading());
    _fetch(arguments.symbol);
  }
}
