import 'package:flutter/material.dart';

import '../../themes/my_theme.dart';

class DatoFila extends StatelessWidget {
  final IconData icono;
  final String etiqueta;
  final Widget valor;
  const DatoFila({
    super.key,
    required this.icono,
    required this.etiqueta,
    required this.valor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Icon(icono, color: AppColors.primary, size: 22),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  etiqueta,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textLight,
                  ),
                ),
                const SizedBox(height: 2),
                DefaultTextStyle.merge(
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textDark,
                  ),
                  child: valor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
