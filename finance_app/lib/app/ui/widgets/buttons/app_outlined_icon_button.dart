import 'package:finance_app/app/ui/theme/space.dart';
import 'package:flutter/material.dart';

class AppOutlinedIconButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final void Function() onPressed;

  const AppOutlinedIconButton({
    Key? key,
    required this.icon,
    required this.onPressed,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [Text(title), Space.horizontal8, Icon(icon)],
      ),
    );
  }
}
