import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/service.dart';
import '../../themes/my_theme.dart';
import '../../widgets/widgets.dart';
import '../error_screen.dart';

/// Detalle de una categoría, con botones para editar y eliminar.
class VerCategoriaScreen extends StatelessWidget {
  const VerCategoriaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final service = Provider.of<CategoriaService>(context);
    final categoria = service.seleccionada;
    if (categoria == null) return const ErrorScreen();

    return Scaffold(
      appBar: AppBar(title: const Text('Detalle de categoría')),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        children: [
          TarjetaBlanca(
            child: Column(
              children: [
                const IconoCuadrado(icono: Icons.category_rounded, size: 80),
                const SizedBox(height: 14),
                Text(
                  categoria.categoryName,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textDark,
                  ),
                ),
                const SizedBox(height: 8),
                EstadoChip(estado: categoria.categoryState),
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
                  valor: Text('${categoria.categoryId}'),
                ),
                const Divider(height: 1),
                DatoFila(
                  icono: Icons.label_outline_rounded,
                  etiqueta: 'Nombre',
                  valor: Text(categoria.categoryName),
                ),
                const Divider(height: 1),
                DatoFila(
                  icono: Icons.toggle_on_outlined,
                  etiqueta: 'Estado',
                  valor: Text(
                    categoria.categoryState.isEmpty
                        ? 'Sin estado'
                        : categoria.categoryState,
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
                            if (!await confirmarEliminar(context, 'categoría')) {
                              return;
                            }
                            final ok = await service.eliminarCategoria(
                              categoria,
                            );
                            if (ok) navigator.pop();
                            messenger.showSnackBar(
                              SnackBar(
                                content: Text(
                                  ok
                                      ? 'Categoría eliminada'
                                      : 'No se pudo eliminar la categoría',
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
                        : () => Navigator.pushNamed(context, 'edit_categoria'),
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
