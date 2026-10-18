import 'dart:convert';

class Product {
  Product({required this.listado});

  List<Listado> listado;

  factory Product.fromJson(String str) => Product.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Product.fromMap(Map<String, dynamic> json) => Product(
    listado: json["Listado"] == null
        ? []
        : List<Listado>.from(
            (json["Listado"] as List).map((x) => Listado.fromMap(x)),
          ),
  );

  Map<String, dynamic> toMap() => {
    "Listado": List<dynamic>.from(listado.map((x) => x.toMap())),
  };
}

class Listado {
  Listado({
    required this.productId,
    required this.productName,
    required this.productPrice,
    required this.productImage,
    required this.productState,
  });

  int productId;
  String productName;
  int productPrice;
  String productImage;
  String productState;

  factory Listado.fromJson(String str) => Listado.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  // Acepta números que lleguen como int, double o String desde la API.
  static int _toInt(dynamic value) {
    if (value is int) return value;
    if (value is num) return value.toInt();
    return int.tryParse('${value ?? ''}') ?? 0;
  }

  factory Listado.fromMap(Map<String, dynamic> json) => Listado(
    productId: _toInt(json["product_id"]),
    productName: json["product_name"]?.toString() ?? '',
    productPrice: _toInt(json["product_price"]),
    productImage: json["product_image"]?.toString() ?? '',
    productState: json["product_state"]?.toString() ?? '',
  );

  Map<String, dynamic> toMap() => {
    "product_id": productId,
    "product_name": productName,
    "product_price": productPrice,
    "product_image": productImage,
    "product_state": productState,
  };

  // json para agregar: {"product_name","product_price","product_image"}
  Map<String, dynamic> toMapAgregar() => {
    "product_name": productName,
    "product_price": productPrice,
    "product_image": productImage,
  };

  // json para editar: igual que agregar pero con id y estado
  Map<String, dynamic> toMapEditar() => {
    "product_id": productId,
    ...toMapAgregar(),
    "product_state": productState.isEmpty ? 'Activo' : productState,
  };

  // json para eliminar: {"product_id":1}
  Map<String, dynamic> toMapEliminar() => {"product_id": productId};

  Listado copy() => Listado(
    productId: productId,
    productName: productName,
    productPrice: productPrice,
    productImage: productImage,
    productState: productState,
  );
}
