import '../helpers/convertir.dart';

// Se llama Proveedor (y no Provider) para no chocar con el paquete provider.
class Proveedor {
  Proveedor({
    required this.providerId,
    required this.providerName,
    required this.providerLastName,
    required this.providerMail,
    required this.providerState,
  });

  int providerId;
  String providerName;
  String providerLastName;
  String providerMail;
  String providerState;

  String get nombreCompleto => '$providerName $providerLastName'.trim();

  // iniciales para el avatar de la tarjeta, ej: "Juan Pérez" -> "JP"
  String get iniciales {
    final a = providerName.isNotEmpty ? providerName[0] : '';
    final b = providerLastName.isNotEmpty ? providerLastName[0] : '';
    final txt = (a + b).toUpperCase();
    return txt.isEmpty ? '?' : txt;
  }

  factory Proveedor.fromMap(Map<String, dynamic> json) => Proveedor(
    providerId: aEntero(json['provider_id']),
    providerName: aTexto(json['provider_name']),
    providerLastName: aTexto(json['provider_last_name']),
    providerMail: aTexto(json['provider_mail']),
    providerState: aTexto(json['provider_state']),
  );

  // json para agregar (sin id)
  Map<String, dynamic> toMapAgregar() => {
    'provider_name': providerName,
    'provider_last_name': providerLastName,
    'provider_mail': providerMail,
    'provider_state': providerState.isEmpty ? 'Activo' : providerState,
  };

  // json para editar (con id)
  Map<String, dynamic> toMapEditar() => {
    'provider_id': providerId,
    ...toMapAgregar(),
  };

  // json para eliminar: {"provider_id":1}
  Map<String, dynamic> toMapEliminar() => {'provider_id': providerId};

  Proveedor copy() => Proveedor(
    providerId: providerId,
    providerName: providerName,
    providerLastName: providerLastName,
    providerMail: providerMail,
    providerState: providerState,
  );
}
