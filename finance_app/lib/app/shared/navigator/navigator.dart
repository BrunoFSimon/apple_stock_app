import 'package:finance_app/app/shared/controller_arguments/controller_arguments.dart';
import 'package:get/get.dart';

class Navigator {
  /// Explicação
  /// Método utilizado para navegar para uma nova página
  /// forçando o programador a passar uma [ControllerArguments]
  /// mesmo que a mesma não contenha informações.
  /// Isso garante que no futuro ao precisar incluir parâmetros não
  /// precisemos buscar por todas as chamadas da rota em questão e incluir o argumento.
  /// Evitando que alguma chamada para a rota fique sem o argumento necessário para
  /// seu funcionamento já que o Analyzer não detecta quando a rota no GetX não está recebendo
  /// o argumento necessário.
  static Future<T> pushPageNamed<T>({
    required ControllerArguments arguments,
    required String route,
  }) async {
    return await Get.toNamed(
      route,
      arguments: arguments,
    );
  }
}
