import 'package:flutter/material.dart';

import '../models/categoria.dart';
import 'api.dart';

class CategoriaService extends ChangeNotifier {
  List<Categoria> categorias = [];
  Categoria? seleccionada;
  bool isLoading = true;
  bool isSaving = false;
  String? errorMessage;

  CategoriaService() {
    cargarCategorias();
  }

    Future<void> cargarCategorias() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();
    try {
      final lista = await Api.getLista('ejemplos/category_list_rest/');
      categorias = lista.map((e) => Categoria.fromMap(e)).toList();
    } catch (e) {
      categorias = [];
      errorMessage = 'No se pudieron cargar las categorías.\n$e';
      debugPrint(errorMessage);
    }
    isLoading = false;
    notifyListeners();
  }

   Future<bool> guardarCategoria(Categoria categoria) async {
    isSaving = true;
    notifyListeners();
    bool ok;
    if (categoria.categoryId == 0) {
      ok = await Api.post(
        'ejemplos/category_add_rest/',
        categoria.toMapAgregar(),
      );
      if (ok) await cargarCategorias(); // para traer el id nuevo
    } else {
      ok = await Api.post(
        'ejemplos/category_edit_rest/',
        categoria.toMapEditar(),
      );
      if (ok) {
        final i = categorias.indexWhere(
          (c) => c.categoryId == categoria.categoryId,
        );
        if (i != -1) categorias[i] = categoria;
        seleccionada = categoria.copy(); // así la pantalla "ver" se actualiza
      }
    }
    isSaving = false;
    notifyListeners();
    return ok;
  }

    Future<bool> eliminarCategoria(Categoria categoria) async {
    isSaving = true;
    notifyListeners();
    final ok = await Api.post(
      'ejemplos/category_del_rest/',
      categoria.toMapEliminar(),
    );
    if (ok) {
      categorias.removeWhere((c) => c.categoryId == categoria.categoryId);
    }
    isSaving = false;
    notifyListeners();
    return ok;
  }
}
