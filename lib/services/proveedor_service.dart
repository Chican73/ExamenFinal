import 'package:flutter/material.dart';

import '../models/proveedor.dart';
import 'api.dart';

class ProveedorService extends ChangeNotifier {
  List<Proveedor> proveedores = [];
  Proveedor? seleccionado;
  bool isLoading = true;
  bool isSaving = false;
  String? errorMessage;

  ProveedorService() {
    cargarProveedores();
  }

    Future<void> cargarProveedores() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();
    try {
      final lista = await Api.getLista('ejemplos/provider_list_rest/');
      proveedores = lista.map((e) => Proveedor.fromMap(e)).toList();
    } catch (e) {
      proveedores = [];
      errorMessage = 'No se pudieron cargar los proveedores.\n$e';
      debugPrint(errorMessage);
    }
    isLoading = false;
    notifyListeners();
  }

    Future<bool> guardarProveedor(Proveedor proveedor) async {
    isSaving = true;
    notifyListeners();
    bool ok;
    if (proveedor.providerId == 0) {
      ok = await Api.post(
        'ejemplos/provider_add_rest/',
        proveedor.toMapAgregar(),
      );
      if (ok) await cargarProveedores();
    } else {
      ok = await Api.post(
        'ejemplos/provider_edit_rest/',
        proveedor.toMapEditar(),
      );
      if (ok) {
        final i = proveedores.indexWhere(
          (p) => p.providerId == proveedor.providerId,
        );
        if (i != -1) proveedores[i] = proveedor;
        seleccionado = proveedor.copy();
      }
    }
    isSaving = false;
    notifyListeners();
    return ok;
  }

    Future<bool> eliminarProveedor(Proveedor proveedor) async {
    isSaving = true;
    notifyListeners();
    final ok = await Api.post(
      'ejemplos/provider_del_rest/',
      proveedor.toMapEliminar(),
    );
    if (ok) {
      proveedores.removeWhere((p) => p.providerId == proveedor.providerId);
    }
    isSaving = false;
    notifyListeners();
    return ok;
  }
}
