import 'package:flutter/material.dart';

import '../models/categoria.dart';

class CategoriaFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  Categoria categoria;
  CategoriaFormProvider(this.categoria);

  void cambiarEstado(String estado) {
    categoria.categoryState = estado;
    notifyListeners();
  }

  bool isValidForm() => formkey.currentState?.validate() ?? false;
}
