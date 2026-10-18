import 'package:flutter/material.dart';
import '../screens/screen.dart';

class AppRoutes {
  static const initialRoute = 'login';
  static Map<String, Widget Function(BuildContext)> routes = {
    'login': (BuildContext context) => const LoginScreen(),
    'register': (BuildContext context) => const RegisterScreen(),
    'home': (BuildContext context) => const HomeScreen(),
    'list_product': (BuildContext context) => const ListProductScreen(),
    'create_product': (BuildContext context) => const CreateProductScreen(),
    'edit_product': (BuildContext context) => const EditProductScreen(),
    // categorías
    'list_categoria': (BuildContext context) => const ListCategoriaScreen(),
    'ver_categoria': (BuildContext context) => const VerCategoriaScreen(),
    'edit_categoria': (BuildContext context) => const EditCategoriaScreen(),
    // proveedores
    'list_proveedor': (BuildContext context) => const ListProveedorScreen(),
    'ver_proveedor': (BuildContext context) => const VerProveedorScreen(),
    'edit_proveedor': (BuildContext context) => const EditProveedorScreen(),
    'error': (BuildContext context) => const ErrorScreen(),
  };

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(builder: (context) => const ErrorScreen());
  }
}
