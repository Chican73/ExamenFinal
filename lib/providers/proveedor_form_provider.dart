import 'package:flutter/material.dart';

import '../models/proveedor.dart';

class ProveedorFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  Proveedor proveedor;
  ProveedorFormProvider(this.proveedor);

  void cambiarEstado(String estado) {
    proveedor.providerState = estado;
    notifyListeners();
  }

  bool isValidForm() => formkey.currentState?.validate() ?? false;
}
