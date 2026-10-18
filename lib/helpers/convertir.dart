/// La API a veces manda los números como texto ("5") y a veces como número (5).
/// Esta función acepta los dos casos y si no puede convertir devuelve 0.
int aEntero(dynamic valor) {
  if (valor is int) return valor;
  if (valor is num) return valor.toInt();
  return int.tryParse('${valor ?? ''}') ?? 0;
}

String aTexto(dynamic valor) => valor?.toString() ?? '';
