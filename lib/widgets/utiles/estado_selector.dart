import 'package:flutter/material.dart';

import '../../themes/my_theme.dart';

class EstadoSelector extends StatelessWidget {
  final String valor;
  final List<String> opciones;
  final ValueChanged<String> onChanged;
  const EstadoSelector({
    super.key,
    required this.valor,
    required this.opciones,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    // si la api trae un estado distinto a las opciones, igual lo muestro
    final lista = [...opciones];
    if (valor.isNotEmpty && !lista.contains(valor)) lista.add(valor);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Estado',
          style: TextStyle(color: AppColors.textLight, fontSize: 13),
        ),
        const SizedBox(height: 6),
        Wrap(
          spacing: 10,
          children: lista
              .map(
                (op) => ChoiceChip(
                  label: Text(op),
                  selected: op == valor,
                  selectedColor: AppColors.primary.withValues(alpha: 0.18),
                  onSelected: (_) => onChanged(op),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
