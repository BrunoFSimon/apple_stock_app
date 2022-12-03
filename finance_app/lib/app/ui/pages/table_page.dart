import 'package:finance_app/app/controllers/table/table_controller.dart';
import 'package:finance_app/app/ui/theme/colors_theme.dart';
import 'package:finance_app/app/ui/theme/space.dart';
import 'package:finance_app/app/ui/theme/text_styles.dart';
import 'package:finance_app/app/ui/widgets/app_error_widget/app_error_widget.dart';
import 'package:finance_app/app/ui/widgets/apple_logo/apple_logo_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TablePage extends GetView<TableController> {
  const TablePage({super.key});

  Color resolveTextColor(int value) {
    return value % 2 == 1 ? ColorsTheme.midGrey : ColorsTheme.darkGrey;
  }

  bool _isFirstItem(int index) => index == 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: controller.obx(
        (state) {
          var result = state;

          if (result == null) throw Exception('state is null');

          return SafeArea(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Space.vertical24,
                  const AppleLogoWidget(),
                  Space.vertical8,
                  Text('Variação de preço nos últimos 30 pregões',
                      style: TextStyles.normal),
                  Space.vertical24,
                  _GridViewItem(
                    childAspectRatio: 1.5,
                    children: [
                      Center(
                        child: Text(
                          'Data',
                          style: TextStyles.normal,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Center(
                        child: Text(
                          'Valor',
                          style: TextStyles.normal,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Center(
                        child: Text(
                          'Variação em relação a D-1',
                          textAlign: TextAlign.center,
                          style: TextStyles.normal,
                        ),
                      ),
                      Center(
                        child: Text(
                          'Variação em relação a primeira data',
                          textAlign: TextAlign.center,
                          style: TextStyles.normal,
                        ),
                      ),
                    ],
                  ),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: result.items.length,
                    itemBuilder: (BuildContext context, int index) {
                      var item = result.items[index];

                      return Container(
                          color: index % 2 == 0 ? Colors.grey[200] : null,
                          padding: const EdgeInsets.only(
                            top: 16,
                            bottom: 8,
                            left: 8,
                            right: 8,
                          ),
                          child: _GridViewItem(
                            childAspectRatio: 5,
                            children: [
                              Text(
                                item.getFormatedDate,
                                style: TextStyles.normal
                                    .setColor(resolveTextColor(index)),
                              ),
                              Text(
                                '${result.currencyCode} ${item.getFormatedValue}',
                                style: TextStyles.normal
                                    .setColor(resolveTextColor(index)),
                              ),
                              if (_isFirstItem(index) == false)
                                Text(
                                  item.getDayBeforeVariationPercent,
                                  textAlign: TextAlign.right,
                                  style: TextStyles.normal
                                      .setColor(resolveTextColor(index)),
                                ),
                              if (_isFirstItem(index) == false)
                                Text(
                                  item.variationBeweenCustomValue(
                                    result.items.first.currentValue,
                                  ),
                                  textAlign: TextAlign.right,
                                  style: TextStyles.normal
                                      .setColor(resolveTextColor(index)),
                                ),
                            ],
                          ));
                    },
                  ),
                ],
              ),
            ),
          );
        },
        onError: (error) {
          return AppErrorWidget(
            message: error ?? 'Erro Desconhecido',
            onRetry: controller.retry,
          );
        },
      ),
    );
  }
}

class _GridViewItem extends StatelessWidget {
  final List<Widget> children;
  final double childAspectRatio;

  const _GridViewItem({
    required this.children,
    required this.childAspectRatio,
  });

  @override
  Widget build(BuildContext context) {
    return GridView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: childAspectRatio,
      ),
      children: children,
    );
  }
}
