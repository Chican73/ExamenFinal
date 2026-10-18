import 'package:flutter/material.dart';

import '../../themes/my_theme.dart';

class EstadoChip extends StatelessWidget {
  final String estado;
  const EstadoChip({super.key, required this.estado});

  static bool esActivo(String estado) =>
      estado.toLowerCase().startsWith('activ');

  @override
  Widget build(BuildContext context) {
    final activo = esActivo(estado);
    final color = activo ? AppColors.primary : AppColors.textLight;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        estado.isEmpty ? 'Sin estado' : estado,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
