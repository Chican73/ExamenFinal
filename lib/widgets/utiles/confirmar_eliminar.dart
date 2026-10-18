import 'package:flutter/material.dart';

import '../../themes/my_theme.dart';

Future<bool> confirmarEliminar(BuildContext context, String que) async {
  final respuesta = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Text('Eliminar $que'),
      content: Text('¿Seguro que quieres eliminar este $que?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text('Cancelar'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, true),
          style: TextButton.styleFrom(foregroundColor: AppColors.danger),
          child: const Text('Eliminar'),
        ),
      ],
    ),
  );
  return respuesta ?? false;
}
