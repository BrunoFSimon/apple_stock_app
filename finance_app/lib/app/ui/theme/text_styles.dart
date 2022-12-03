import 'package:flutter/material.dart';

/// Explicação
/// Classe utilizada para padronizar os estilos de texto utilizados no app.
class TextStyles {
  static get normal => const TextStyle(color: Colors.grey);
  static get normalBig => const TextStyle(color: Colors.grey, fontSize: 24);
  static get boldBig => const TextStyle(
      color: Colors.grey, fontSize: 24, fontWeight: FontWeight.bold);
}
