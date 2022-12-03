import 'package:dio/dio.dart';
import 'package:finance_app/app/data/provider/finance_chart_provider.dart';
import 'package:finance_app/app/data/repository/finance_chart_repository.dart';
import 'package:finance_app/app/shared/http/http_client.dart';
import 'package:finance_app/app/shared/http/impl/dio_http_client.dart';
import 'package:get/get.dart';

/// Explicação
/// Classe utilizada para centralizar a injeção de dependências com exceção
/// das dependências de rotas, estas são gerenciadas pelo
/// GetX no arquivo [AppPages] e seus respectivos bindings.
class ServicesInitializer {
  static Future<void> initialize() async {
    Get.lazyPut<HttpClient>(() => DioHttpClient(Dio()), fenix: true);

    Get.lazyPut<FinanceChartRepository>(
        () => FinanceChartRepositoryImpl(Get.find()),
        fenix: true);

    Get.lazyPut<FinanceChartProvider>(
        () => FinanceChartProviderImpl(Get.find()),
        fenix: true);
  }
}
