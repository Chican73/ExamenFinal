import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/categoria_form_provider.dart';
import '../../services/service.dart';
import '../../themes/my_theme.dart';
import '../../ui/input_decorations.dart';
import '../../widgets/widgets.dart';
import '../error_screen.dart';


class EditCategoriaScreen extends StatelessWidget {
  const EditCategoriaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final service = Provider.of<CategoriaService>(context);
    final seleccionada = service.seleccionada;
    if (seleccionada == null) return const ErrorScreen();
    return ChangeNotifierProvider(
      
      create: (_) => CategoriaFormProvider(seleccionada.copy()),
      child: _FormularioCategoria(service: service),
    );
  }
}

class _FormularioCategoria extends StatelessWidget {
  final CategoriaService service;
  const _FormularioCategoria({required this.service});

  @override
  Widget build(BuildContext context) {
    final form = Provider.of<CategoriaFormProvider>(context);
    final categoria = form.categoria;
    final esNueva = categoria.categoryId == 0;

    return Scaffold(
      appBar: AppBar(
        title: Text(esNueva ? 'Nueva categoría' : 'Editar categoría'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: TarjetaBlanca(
          child: Form(
            key: form.formkey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: IconoCuadrado(icono: Icons.category_rounded, size: 70),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  initialValue: categoria.categoryName,
                  textCapitalization: TextCapitalization.sentences,
                  onChanged: (value) => categoria.categoryName = value.trim(),
                  validator: (value) => (value == null || value.trim().isEmpty)
                      ? 'El nombre es obligatorio'
                      : null,
                  decoration: InputDecorations.authInputDecoration(
                    hinText: 'Ej: Bebidas',
                    labelText: 'Nombre de la categoría',
                    prefixIcon: Icons.label_outline_rounded,
                  ),
                ),
                // al agregar la api solo recibe el nombre, el estado se
                // puede cambiar después al editar
                if (!esNueva) ...[
                  const SizedBox(height: 18),
                  EstadoSelector(
                    valor: categoria.categoryState,
                    opciones: const ['Activa', 'Inactiva'],
                    onChanged: form.cambiarEstado,
                  ),
                ],
                const SizedBox(height: 26),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: service.isSaving
                        ? null
                        : () async {
                            FocusScope.of(context).unfocus();
                            if (!form.isValidForm()) return;
                            final navigator = Navigator.of(context);
                            final messenger = ScaffoldMessenger.of(context);
                            final ok = await service.guardarCategoria(categoria);
                            if (ok) navigator.pop();
                            messenger.showSnackBar(
                              SnackBar(
                                content: Text(
                                  ok
                                      ? (esNueva
                                            ? 'Categoría creada'
                                            : 'Cambios guardados')
                                      : 'No se pudo guardar la categoría',
                                ),
                              ),
                            );
                          },
                    icon: service.isSaving
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2.5,
                            ),
                          )
                        : const Icon(Icons.save_rounded),
                    label: Text(service.isSaving ? 'Guardando...' : 'Guardar'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: AppColors.background,
    );
  }
}
