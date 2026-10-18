import 'package:flutter/material.dart';

import '../themes/my_theme.dart';
import '../widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Inicio'),
        actions: [
          IconButton(
            tooltip: 'Cerrar sesión',
            onPressed: () {
              // se limpia el historial para que no se pueda volver atrás
              Navigator.pushNamedAndRemoveUntil(
                context,
                'login',
                (route) => false,
              );
            },
            icon: const Icon(Icons.logout_rounded),
          ),
        ],
      ),
      body: ListView(
        children: [
          // cabecera de bienvenida
          Container(
            margin: const EdgeInsets.fromLTRB(20, 20, 20, 12),
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.primary, AppColors.primaryDark],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '¡Bienvenido!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        '¿Qué quieres comprar hoy?',
                        style: TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.shopping_bag_outlined, color: Colors.white54, size: 48),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(24, 8, 24, 4),
            child: Text(
              'Menú de inicio',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.textDark,
              ),
            ),
          ),
          const Button(
            pathButton: 'list_product',
            textButton: 'Productos',
            subtitle: 'Ver, crear y editar productos',
            icon: Icons.inventory_2_outlined,
          ),
          const Button(
            pathButton: 'list_categoria',
            textButton: 'Categorías',
            subtitle: 'Ver, crear, editar y eliminar categorías',
            icon: Icons.category_outlined,
          ),
          const Button(
            pathButton: 'list_proveedor',
            textButton: 'Proveedores',
            subtitle: 'Ver, crear, editar y eliminar proveedores',
            icon: Icons.local_shipping_outlined,
          ),
        ],
      ),
    );
  }
}
