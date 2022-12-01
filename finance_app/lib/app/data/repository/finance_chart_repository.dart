import 'package:finance_app/app/data/model/get_finance_chart_model.dart';
import 'package:finance_app/app/data/provider/finance_chart_provider.dart';

abstract class FinanceChartRepository {
  Future<GetFinanceChartModel> getFinanceChart(String symbol);
}

class FinanceChartRepositoryImpl implements FinanceChartRepository {
  final FinanceChartProvider _provider;

  FinanceChartRepositoryImpl(this._provider);

  @override
  Future<GetFinanceChartModel> getFinanceChart(String symbol) {
    return _provider.getFinanceChart(symbol);
  }
}
