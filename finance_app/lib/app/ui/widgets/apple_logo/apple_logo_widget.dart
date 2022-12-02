import 'package:finance_app/app/ui/theme/text_styles.dart';
import 'package:flutter/material.dart';

class AppleLogoWidget extends StatelessWidget {
  const AppleLogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Icon(
          Icons.apple,
          color: Colors.grey,
          size: 50,
        ),
        Text(
          'AAPL',
          textAlign: TextAlign.center,
          style: TextStyles.boldBig,
        ),
      ],
    );
  }
}
