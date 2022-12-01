import 'package:finance_app/app/controllers/home/home_arguments.dart';
import 'package:finance_app/app/data/model/get_finance_chart_model.dart';
import 'package:finance_app/app/data/repository/finance_chart_repository.dart';
import 'package:get/get.dart';

class HomeController extends GetxController
    with StateMixin<GetFinanceChartModel> {
  final FinanceChartRepository repository;

  final HomeArguments arguments; // TODO - explain it

  HomeController({
    required this.repository,
    required this.arguments,
  });

  @override
  void onInit() {
    _fetch(arguments.symbol);
    super.onInit();
  }

  Future<void> _fetch(String symbol) async {
    change(null, status: RxStatus.loading());
    try {
      var response = await repository.getFinanceChart(symbol);
      change(response, status: RxStatus.success());
    } on Exception catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }
  }

  void retry() => _fetch(arguments.symbol);
}
