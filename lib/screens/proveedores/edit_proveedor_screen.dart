import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/proveedor_form_provider.dart';
import '../../services/service.dart';
import '../../ui/input_decorations.dart';
import '../../widgets/widgets.dart';
import '../error_screen.dart';

class EditProveedorScreen extends StatelessWidget {
  const EditProveedorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final service = Provider.of<ProveedorService>(context);
    final seleccionado = service.seleccionado;
    if (seleccionado == null) return const ErrorScreen();
    return ChangeNotifierProvider(
      create: (_) => ProveedorFormProvider(seleccionado.copy()),
      child: _FormularioProveedor(service: service),
    );
  }
}

class _FormularioProveedor extends StatelessWidget {
  final ProveedorService service;
  const _FormularioProveedor({required this.service});

  static String? _obligatorio(String? value, String campo) =>
      (value == null || value.trim().isEmpty) ? 'El $campo es obligatorio' : null;

  @override
  Widget build(BuildContext context) {
    final form = Provider.of<ProveedorFormProvider>(context);
    final proveedor = form.proveedor;
    final esNuevo = proveedor.providerId == 0;

    return Scaffold(
      appBar: AppBar(
        title: Text(esNuevo ? 'Nuevo proveedor' : 'Editar proveedor'),
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
                  child: IconoCuadrado(
                    icono: Icons.local_shipping_rounded,
                    size: 70,
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  initialValue: proveedor.providerName,
                  textCapitalization: TextCapitalization.words,
                  onChanged: (value) => proveedor.providerName = value.trim(),
                  validator: (value) => _obligatorio(value, 'nombre'),
                  decoration: InputDecorations.authInputDecoration(
                    hinText: 'Ej: Juan',
                    labelText: 'Nombre',
                    prefixIcon: Icons.person_outline_rounded,
                  ),
                ),
                const SizedBox(height: 14),
                TextFormField(
                  initialValue: proveedor.providerLastName,
                  textCapitalization: TextCapitalization.words,
                  onChanged: (value) =>
                      proveedor.providerLastName = value.trim(),
                  validator: (value) => _obligatorio(value, 'apellido'),
                  decoration: InputDecorations.authInputDecoration(
                    hinText: 'Ej: Pérez',
                    labelText: 'Apellido',
                    prefixIcon: Icons.badge_outlined,
                  ),
                ),
                const SizedBox(height: 14),
                TextFormField(
                  initialValue: proveedor.providerMail,
                  autocorrect: false,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) => proveedor.providerMail = value.trim(),
                  validator: (value) {
                    // misma expresión regular que el login
                    final regExp = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
                    return (value != null && regExp.hasMatch(value.trim()))
                        ? null
                        : 'Ingrese un correo válido';
                  },
                  decoration: InputDecorations.authInputDecoration(
                    hinText: 'correo@correo.cl',
                    labelText: 'Correo',
                    prefixIcon: Icons.alternate_email_rounded,
                  ),
                ),
                const SizedBox(height: 18),
                EstadoSelector(
                  valor: proveedor.providerState,
                  opciones: const ['Activo', 'Inactivo'],
                  onChanged: form.cambiarEstado,
                ),
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
                            final ok = await service.guardarProveedor(proveedor);
                            if (ok) navigator.pop();
                            messenger.showSnackBar(
                              SnackBar(
                                content: Text(
                                  ok
                                      ? (esNuevo
                                            ? 'Proveedor creado'
                                            : 'Cambios guardados')
                                      : 'No se pudo guardar el proveedor',
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
    );
  }
}
