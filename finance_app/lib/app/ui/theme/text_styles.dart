import 'package:flutter/material.dart';

/// Explicação
/// Classe utilizada para padronizar os estilos de texto utilizados no app.
class TextStyles {
  static TextStyle get normal => const TextStyle(color: Colors.grey);
  static TextStyle get verySmall =>
      const TextStyle(color: Colors.grey, fontSize: 8);
  static TextStyle get normalBig =>
      const TextStyle(color: Colors.grey, fontSize: 24);
  static TextStyle get boldBig => const TextStyle(
      color: Colors.grey, fontSize: 24, fontWeight: FontWeight.bold);
}

extension TextStyleExtension on TextStyle {
  TextStyle setColor(Color color) {
    return copyWith(color: color);
  }
}
