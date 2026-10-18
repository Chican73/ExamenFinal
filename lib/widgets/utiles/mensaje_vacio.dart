import 'package:flutter/material.dart';

import '../../themes/my_theme.dart';

class MensajeVacio extends StatelessWidget {
  final IconData icono;
  final String texto;
  final VoidCallback onReintentar;
  const MensajeVacio({
    super.key,
    required this.icono,
    required this.texto,
    required this.onReintentar,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icono, size: 70, color: AppColors.textLight),
            const SizedBox(height: 16),
            Text(
              texto,
              textAlign: TextAlign.center,
              style: const TextStyle(color: AppColors.textDark),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: onReintentar,
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('Reintentar'),
            ),
          ],
        ),
      ),
    );
  }
}
