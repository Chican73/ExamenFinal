import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/proveedor.dart';
import '../../services/service.dart';
import '../../themes/my_theme.dart';
import '../../widgets/widgets.dart';

class ListProveedorScreen extends StatelessWidget {
  const ListProveedorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final service = Provider.of<ProveedorService>(context);
    final proveedores = service.proveedores;

    Widget cuerpo;
    if (service.isLoading) {
      cuerpo = const Center(
        child: CircularProgressIndicator(color: AppColors.primary),
      );
    } else if (service.errorMessage != null && proveedores.isEmpty) {
      cuerpo = MensajeVacio(
        icono: Icons.wifi_off_rounded,
        texto: service.errorMessage!,
        onReintentar: service.cargarProveedores,
      );
    } else if (proveedores.isEmpty) {
      cuerpo = MensajeVacio(
        icono: Icons.local_shipping_outlined,
        texto: 'Aún no hay proveedores.\nPresiona + para agregar uno.',
        onReintentar: service.cargarProveedores,
      );
    } else {
      cuerpo = RefreshIndicator(
        color: AppColors.primary,
        onRefresh: service.cargarProveedores,
        child: ListView.builder(
          padding: const EdgeInsets.only(top: 10, bottom: 90),
          itemCount: proveedores.length + 1,
          itemBuilder: (context, index) {
            if (index == 0) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(24, 6, 24, 6),
                child: Text(
                  '${proveedores.length} proveedores registrados',
                  style: const TextStyle(color: AppColors.textLight),
                ),
              );
            }
            final proveedor = proveedores[index - 1];
            return ItemCard(
              leading: IconoCuadrado(texto: proveedor.iniciales),
              titulo: proveedor.nombreCompleto,
              subtitulo: proveedor.providerMail,
              estado: proveedor.providerState,
              onTap: () {
                service.seleccionado = proveedor.copy();
                Navigator.pushNamed(context, 'ver_proveedor');
              },
            );
          },
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Proveedores'),
        actions: [
          IconButton(
            tooltip: 'Recargar',
            onPressed: service.cargarProveedores,
            icon: const Icon(Icons.refresh_rounded),
          ),
        ],
      ),
      body: cuerpo,
      floatingActionButton: FloatingActionButton(
        tooltip: 'Agregar proveedor',
        child: const Icon(Icons.add_rounded, size: 30),
        onPressed: () {
          service.seleccionado = Proveedor(
            providerId: 0,
            providerName: '',
            providerLastName: '',
            providerMail: '',
            providerState: 'Activo',
          );
          Navigator.pushNamed(context, 'edit_proveedor');
        },
      ),
    );
  }
}
