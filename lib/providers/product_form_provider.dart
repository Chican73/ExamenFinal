import 'package:flutter/material.dart';

import '../models/product.dart';

class ProductFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  Listado product;
  ProductFormProvider(this.product);
  void actualizarImagen(String url) {
    product.productImage = url.trim();
    notifyListeners();
  }

  bool isValidForm() {
    return formkey.currentState?.validate() ?? false;
  }
}
