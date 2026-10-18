import '../helpers/convertir.dart';

class Categoria {
  Categoria({
    required this.categoryId,
    required this.categoryName,
    required this.categoryState,
  });

  int categoryId;
  String categoryName;
  String categoryState;

  factory Categoria.fromMap(Map<String, dynamic> json) => Categoria(
    categoryId: aEntero(json['category_id']),
    categoryName: aTexto(json['category_name']),
    categoryState: aTexto(json['category_state']),
  );

  // json para agregar: {"category_name":"nombre"}
  Map<String, dynamic> toMapAgregar() => {'category_name': categoryName};

  // json para editar: {"category_id":1,"category_name":"nombre","category_state":"Activa"}
  Map<String, dynamic> toMapEditar() => {
    'category_id': categoryId,
    'category_name': categoryName,
    'category_state': categoryState.isEmpty ? 'Activa' : categoryState,
  };

  // json para eliminar: {"category_id":1}
  Map<String, dynamic> toMapEliminar() => {'category_id': categoryId};

  Categoria copy() => Categoria(
    categoryId: categoryId,
    categoryName: categoryName,
    categoryState: categoryState,
  );
}
