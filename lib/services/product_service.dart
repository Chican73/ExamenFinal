import 'package:flutter/material.dart';

import '../models/product.dart';
import 'api.dart';

class ProductService extends ChangeNotifier {
  List<Listado> products = [];
  Listado? selectedProduct;
  bool isSaving = false;
  bool isLoading = true;
  String? errorMessage;

  ProductService() {
    loadProducts();
  }

  // GET ejemplos/product_list_rest/
  Future<void> loadProducts() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();
    try {
      final lista = await Api.getLista('ejemplos/product_list_rest/');
      products = lista.map((e) => Listado.fromMap(e)).toList();
    } catch (e) {
      products = [];
      errorMessage = 'No se pudieron cargar los productos.\n$e';
      debugPrint(errorMessage);
    }
    isLoading = false;
    notifyListeners();
  }

  /// Devuelve true si la operación se realizó correctamente.
  Future<bool> editOrCreateProduct(Listado product) async {
    isSaving = true;
    notifyListeners();
    final bool ok = product.productId == 0
        ? await _createProduct(product)
        : await _updateProduct(product);
    isSaving = false;
    notifyListeners();
    return ok;
  }

  // POST ejemplos/product_add_rest/
  Future<bool> _createProduct(Listado product) async {
    final ok = await Api.post(
      'ejemplos/product_add_rest/',
      product.toMapAgregar(),
    );
    // Se recarga el listado para obtener el id real asignado por el servidor.
    if (ok) await loadProducts();
    return ok;
  }

  // POST ejemplos/product_edit_rest/
  Future<bool> _updateProduct(Listado product) async {
    final ok = await Api.post(
      'ejemplos/product_edit_rest/',
      product.toMapEditar(),
    );
    if (ok) {
      final index = products.indexWhere(
        (element) => element.productId == product.productId,
      );
      if (index != -1) products[index] = product;
    }
    return ok;
  }

  // POST ejemplos/product_del_rest/
  Future<bool> deleteProduct(Listado product) async {
    // Un producto nuevo (id 0) aún no existe en el servidor.
    if (product.productId == 0) return true;
    isSaving = true;
    notifyListeners();
    final ok = await Api.post(
      'ejemplos/product_del_rest/',
      product.toMapEliminar(),
    );
    if (ok) {
      products.removeWhere((element) => element.productId == product.productId);
    }
    isSaving = false;
    notifyListeners();
    return ok;
  }
}
