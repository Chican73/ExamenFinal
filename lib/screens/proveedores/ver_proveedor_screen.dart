import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/service.dart';
import '../../themes/my_theme.dart';
import '../../widgets/widgets.dart';
import '../error_screen.dart';

/// Detalle de un proveedor, con botones para editar y eliminar.
class VerProveedorScreen extends StatelessWidget {
  const VerProveedorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final service = Provider.of<ProveedorService>(context);
    final proveedor = service.seleccionado;
    if (proveedor == null) return const ErrorScreen();

    return Scaffold(
      appBar: AppBar(title: const Text('Detalle de proveedor')),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        children: [
          TarjetaBlanca(
            child: Column(
              children: [
                IconoCuadrado(texto: proveedor.iniciales, size: 80),
                const SizedBox(height: 14),
                Text(
                  proveedor.nombreCompleto,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textDark,
                  ),
                ),
                Text(
                  proveedor.providerMail,
                  style: const TextStyle(color: AppColors.textLight),
                ),
                const SizedBox(height: 8),
                EstadoChip(estado: proveedor.providerState),
              ],
            ),
          ),
          TarjetaBlanca(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Column(
              children: [
                DatoFila(
                  icono: Icons.tag_rounded,
                  etiqueta: 'Código',
                  valor: Text('${proveedor.providerId}'),
                ),
                const Divider(height: 1),
                DatoFila(
                  icono: Icons.person_outline_rounded,
                  etiqueta: 'Nombre',
                  valor: Text(proveedor.providerName),
                ),
                const Divider(height: 1),
                DatoFila(
                  icono: Icons.badge_outlined,
                  etiqueta: 'Apellido',
                  valor: Text(proveedor.providerLastName),
                ),
                const Divider(height: 1),
                DatoFila(
                  icono: Icons.alternate_email_rounded,
                  etiqueta: 'Correo',
                  valor: Text(proveedor.providerMail),
                ),
                const Divider(height: 1),
                DatoFila(
                  icono: Icons.toggle_on_outlined,
                  etiqueta: 'Estado',
                  valor: Text(
                    proveedor.providerState.isEmpty
                        ? 'Sin estado'
                        : proveedor.providerState,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.danger,
                      side: const BorderSide(color: AppColors.danger),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: service.isSaving
                        ? null
                        : () async {
                            final navigator = Navigator.of(context);
                            final messenger = ScaffoldMessenger.of(context);
                            if (!await confirmarEliminar(context, 'proveedor')) {
                              return;
                            }
                            final ok = await service.eliminarProveedor(
                              proveedor,
                            );
                            if (ok) navigator.pop();
                            messenger.showSnackBar(
                              SnackBar(
                                content: Text(
                                  ok
                                      ? 'Proveedor eliminado'
                                      : 'No se pudo eliminar el proveedor',
                                ),
                              ),
                            );
                          },
                    icon: const Icon(Icons.delete_outline_rounded),
                    label: const Text('Eliminar'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: service.isSaving
                        ? null
                        : () => Navigator.pushNamed(context, 'edit_proveedor'),
                    icon: const Icon(Icons.edit_outlined),
                    label: const Text('Editar'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
